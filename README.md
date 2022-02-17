# CountdownSolver
A simple solver for a puzzle game similar to the Numbers round from the Countdown game show

## Usage

You will need OCaml to run the solver. Currently, the solver has no main function. I recommened loading the source file into OCaml's `toplevel` (the OCaml interactive session) to try it out.

Solver is found in `src/countdown.ml`. Use `timed_solve <target> <numbers list>` to run solver with timer.

e.g.
```
# timed_solve 937 [15;10;53;2;41;19];;
Solutions found: 1
937 = (((53*(19-2))-(15-10))+41)
Configurations explored: 141801
Execution time: 0.213400s
```

A standard Numbers round contains 6 numbers and a target, all of which need to be 3 digits or less. This solver can take numbers of any size and any number of numbers as long as they are positive and integers, with no fractional part in any of the computations needed.

e.g.
```
# timed_solve 937 [15;10;53;2;41;19;20];;
Solutions found: 10
937 = (((((53+41)*10)-2)-20)+19)
937 = (((53*(19-2))-(15-10))+41)
937 = (((41+10)*(20-2))+19)
937 = (((41+(15-10))*20)+(19-2))
937 = (((((53+15)-19)*20)-41)-2)
937 = ((53*19)-((20+15)*2))
937 = ((53*20)-(41*((15-10)-2)))
937 = ((((15+10)+20)*(41-19))-53)
937 = (((((15+10)*19)+20)*2)-53)
937 = ((((53*41)+(20-19))/2)-(15*10))
Configurations explored: 2540486
Execution time: 5.211323s
```

## Base algorithm

The algorithm is based on a description by Dr. Joe Billingsley. The implementation is based on reducing configurations to a fix-point much like reduction systems.

### Concept
- *Configurations*: set of numbers `C = {N_1 , N_2 , N_3 , ... , N_n}`
- *Reduction Step*:
  1. remove two numbers from the configuration: `N_i` and `N_j`
  2. apply an operator from `+`,`-`,`*`,`/`: `N_k = N_i (+) N_j`
  3. return new number `N_k` to configruation: `(C-{N_i,N_j}) union {N_k}`

The search applies the transitive closure of the above reduction for every pair in the initial configuration.

### Implementation
Configurations are lists of numbers `[N_1; ... ; N_n]`. Given a configuration `C`, the search step adds new configurations for every operation for every pair of numbers in `C`. The search recursively applies this search step for every configuration in the list of pending configurations.

## Optimisations

### Rules to prune an operation `N_i (+) N_j`
- *Addition*:
  - Commutativity: skip if `N_j > N_i`
  - Left identity: skip if `N_i = 0`
  - Right identity: skip if `N_j = 0`
- *Subtraction*:
  - No negatives: skip if `N_j > N_i`
  - Right identity: skip if `N_j = 0`
  - "Left identity" (don't know what this is called): skip if `N_i = 2N_j`
- *Multiplication*:
  - Commutativity: skip if `N_j > N_i`
  - Left identity: skip if `N_i = 1`
  - Right identity: skip if `N_j = 1`
- *Division*:
  - Right identity: skip if `N_j = 1`
  - Division by zero: skip if `N_j = 0`
  - No fractional part: skip if `N_i mod N_j <> 0`
  - "Left identity" (don't know what this is called): skip if `N_i = N_j^2`

### Basic Explore-Set Memoisation [superseeded]
Configurations become lists of numbers with the expressions used to produce them: `[(N_1,E_1); ... ; (N_n,E_n)]`.
e.g. `[(2,1+1); (3,2+1); (5,5); (6,3*2)]`

Add a hashtable `memo` of all configurations seen. If an operation `N_i (+) N_j` were to produce a configuration `C'` such that `memo(C')` exists, then the operation is skipped. If `memo(C')` does not exist, then `memo` is updated with `C'`.

### Normalised Minimal Configuration Memoisation [superseeded]
Instead of remembering a configuration `C`, memo now remembers a minimal and normalised version `norm(min(C))`.

- *Normalisation*: simply sorts `C` from smallest to largest.
e.g. `[5;2;3;4]` and `[2;5;4;3]` would both normalise to the same configuration `[2;3;4;5]`.
- *Minimisation*: instead of remembering every expression `E_i` in an element `(N_i,E_i)` in `C`, we remember an ordered list of numbers `I_i` used to produce `N_i`.
e.g. `[(2,1+1); (3,2+1); (5,5); (6,3*2)] => [(2,[1;1]); (3,[1;2]); (5,[5]); (6,[2;3])]`

The intuition is that minimisation captures an equivalence class defined by transposition (rearrangement) of expressions as symbolic expressions (without reduction), whereas normalisation captures an equivalence class defined by the order in which non-interfering pairs are chosen, as well as some convergent paths in the exploration (including associative operations on the same numbers).

### Dropped-Expression Normalised Configuration Memoisation [current]
This is in fact the more obvious way of doing explore-set memoisation. Instead of keeping track of the expression or the numbers involved in the expressions, it suffices to remember just the results in the configuration. By dropping the expressions, we capture all possible ways to reach a given set of numbers, including symbolic transposition.

### Tail Recursion
Transforming all functions to be tail-recursive is an obvious standard optimisation that was very significant in this exercise. I observed a speed up of at least an order of magnitude or two just by making every function tail recursive.

### Solved-Configuration Removal
Probably the most obvious "optimisation": removing all configurations that include the target in them from the list of pending configurations. This prevents duplicate solutions generated by the expansion of solved configurations. Not very significant in my limited set of experiments. Removed about 0.06% to 0.07% of configurations explored.

### Merging Operations
My original implementation did things in steps for a conceptually simpler design:

i.e. (1) generate pairs, (2) list all operations from said pairs, (3) memoise all new configurations and drop those seen already, (4) check every new configuration for solved states and drop those.

The original implementation took in the order of hundreds of seconds to solve for one solution for 6 numbers, with exploring the entire state-space being completely infeasible. While memoisation did a lot to reduce time, I estimate merging operations had a similar or bigger impact on performance, as it also allowed tail-recursion transformations. Firstly, choosing pairs and generating operations from those pairs can be merged into a single step. This can then be further merged with memoisation by checking every new configuration for memoisation. Further still, memoisation and solution checking can be merged, as can be dropping solved configurations. The end result is a single function that performs the entire search step in one step instead of four. Passing the set of solved solutions then allowed everything to become tail recursive. The end result is a runtime of around 0.2s to explore the entire (pruned) state-space for 6 numbers.
