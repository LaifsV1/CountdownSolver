(* countdown number game solver:
   author: Yu-Yang Lin
   base algorithm idea: Joe Billingsley *)
(* types *)
type ops = Add | Sub | Mul | Div                 (* operators *)
type exp = Num of int | Op of ops * exp * exp    (* expressions *)
type num_exp = int * exp                         (* result , expression *)
type conf = num_exp list                         (* confs: list of num_exp *)
type min_conf = (int) list                       (* min normalised (sorted) conf for memo *)

(* helper funcs for types *)
let minimal_cfg : conf -> min_conf = fun cfg ->  (* minimises confs *)
  let minimise (a,_) = (a) in
  List.sort compare (List.map minimise cfg)
let get_int : num_exp -> int = fun (a,_) -> a    (* gets result side of num_exp *)

(* memoisation stuff *)
let memo_size = 100000
let memo = ref (Hashtbl.create memo_size)        (* memoisation hashtable *)
let conf_count = ref 0                           (* configuration count *)

(* custom operators to make code easier to write *)
let ( +~ ) (i,e1) (j,e2) = (i+j,Op(Add,e1,e2))
let ( -~ ) (i,e1) (j,e2) = (i-j,Op(Sub,e1,e2))
let ( *~ ) (i,e1) (j,e2) = (i*j,Op(Mul,e1,e2))
let ( /~ ) (i,e1) (j,e2) = (i/j,Op(Div,e1,e2))
let string_of_op = function
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
let rec string_of_exp = function
  | Num i -> string_of_int i
  | Op(op,e1,e2) ->
     Printf.sprintf "(%s%s%s)"
       (string_of_exp e1) (string_of_op op) (string_of_exp e2)
(* string functions for debugging *)
let string_of_num_exp (i,e) = Printf.sprintf "(%d,%s)" i (string_of_exp e)
let string_of_conf conf =
  Printf.sprintf "[%s]" (String.concat ";" ((List.map string_of_num_exp) conf))

(* converts integers to expressions *)
let nums_to_exp ls = List.map (fun a -> a,Num a) ls
(* general list delete function *)
let list_del a b ls =
  let rec list_del' (a,a_found) (b,b_found) ls acc =
    match ls with
    | [] -> assert(a_found && b_found); acc
    | x :: xs ->
       if (a = x) & not(a_found) then list_del' (a,true) (b,b_found) xs acc else
         if (b = x) & not(b_found) then list_del' (a,a_found) (b,true) xs acc else
           list_del' (a,a_found) (b,b_found) xs (x::acc)
  in
  list_del' (a,false) (b,false) ls []

(* generates all possible expressions for every pair in the conf *)
let rec search sol confs sols =
  let pairs conf confs sol sols =
    let ops_of_pair (a,b) (confs',sols') =
      let a' = get_int a in
      let b' = get_int b in
      let new_conf = (list_del a b conf) in
      let check_memo_and_sol (res,exp) (cfgs,sols) =
        conf_count := !conf_count + 1;
        let c = (res,exp)::new_conf in
        let c' = minimal_cfg c in                (* minimises configuration for memo *)
        if Hashtbl.mem !memo c' then (cfgs,sols) (* if memoised, skip *)
        else
          (Hashtbl.add !memo c' ();              (* add c to memo *)
           if res = sol then (cfgs,exp::sols)    (* if c solved, add to sols and skip c*)
           else (c::cfgs,sols))                  (* else, add c to cfgs and keep sols *)
      in
      let adds = if a' < b'                      (* commutativity *)
                    || a' = 0                    (* left identity*)
                    || b' = 0                    (* right identity*)
                 then (confs',sols')
                 else check_memo_and_sol (a +~ b) (confs',sols') in
      let subs = if a' < b'                      (* no negatives *)
                    || b' = 0                    (* right identity *)
                    || a' = b' + b'              (* "left identity" (idk) *)
                 then adds
                 else check_memo_and_sol (a -~ b) adds in
      let muls = if a' < b'                      (* commutativity *)
                    || a' = 1                    (* left identity *)
                    || b' = 1                    (* right identity *)
                 then subs
                 else check_memo_and_sol (a *~ b) subs in
      let divs = if b' <= 1                      (* right identity & div-by-0 *)
                    || a' = b' * b'              (* "left identity" (idk) *)
                    || a' mod b' <> 0            (* no remainders allowed *)
                 then muls
                 else check_memo_and_sol (a /~ b) muls in
      divs
    in
    let conf = (fst (List.fold_left (fun (acc,i) a -> (a,i+1)::acc,i+1) ([],0) conf)) in
    List.fold_left                               (* for every a_i in conf *)
      (fun acc (a,i) ->
        (List.fold_left                          (* for every b_j in conf *)
           (fun acc' (b,j)  ->
             if i=j then acc'                    (* if i = j skip else create ops(a,b) *)
             else (ops_of_pair (a,b) acc')) acc conf)) (confs,sols) conf
  in
  match confs with
  | [] -> sols
  | conf::rest ->
     let new_cfgs,new_sols = pairs conf rest sol sols in
     search sol new_cfgs new_sols

(* solve: converts numbers to expressions and passes this to the search function *)
let solve sol nums =
  let exps = nums_to_exp nums in
  let sols = search sol [exps] [] in
  begin
    let pruned_sols = List.sort_uniq compare sols in
    match pruned_sols with       (* remove duplicates *)
    | [] -> Printf.printf "No solution found\n"
    | exps ->
       Printf.printf "Solutions found: %d\n" (List.length pruned_sols);
       List.fold_left
         (fun _ exp -> Printf.printf "%d = %s\n" sol (string_of_exp exp)) () exps
  end;
  Printf.printf "Configurations explored: %d\n" (!conf_count)

let timed_solve sol nums =
  memo := (Hashtbl.create memo_size);
  conf_count := 0;
  let t = Sys.time() in
  let res = solve sol nums in
  Printf.printf "Execution time: %fs\n" (Sys.time() -. t);
  res
