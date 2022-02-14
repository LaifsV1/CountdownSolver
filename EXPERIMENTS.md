# Experiments

Very informal record of a very small set of experiments.

## ADDED BASIC MEMOISATION
```
# timed_solve 937 [15;10;53;2;41;19];;
solution found: ((53*19)-(10*(15/2)))
Execution time: 81.580886s

# timed_solve 937 [16;10;25;11;30;40];;
solution found: (((25+11)*(16+10))+(40/30))
Execution time: 83.126824s

# timed_solve 997 [4;53;47;107;71;43];;
solution found: ((((47*43)*53)/107)-4)
Execution time: 105.407378s
```

## SOME FUNCTIONS NOW TAIL RECURSIVE
```
# timed_solve 937 [15;10;53;2;41;19];;
solution found: ((((41*10)+(53+15))*2)-19)
Execution time: 29.698953s

# timed_solve 997 [4;53;47;107;71;43];;
solution found: ((((107*4)*(53+47))+71)/43)
Execution time: 20.136069s
```

## NORMALISED MINIMAL CFG MEMOISATION (disallowed fractional parts)
```
# timed_solve 937 [15;10;53;2;41;19];;
solution found: ((53*(19-2))+(41-(15-10)))
configurations explored: 84823
Execution time: 2.250153s

# timed_solve 997 [4;53;47;107;71;43];;
solution found: ((47*(71-43))-((53*4)+107))
configurations explored: 84574
Execution time: 2.873299s

# timed_solve 937 [16;10;25;11;30;40];;
no solution found
configurations explored: 118464
Execution time: 4.526606s
```

## STOPPED ADDING CFG WHEN (A,B) DOESN'T SATISFY OPERATION RULES. MERGED PAIR CREATION AND OP GENERATION AND MADE EVERYTHING TAIL RECURSIVE.
### WITH MEMO:
```
# timed_solve 937 [15;10;53;2;41;19];;
solution found: ((53*(19-2))+(41-(15-10)))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: ((53*(19-2))+(41-(15-10)))
Configurations explored: 41380
Execution time: 0.336336s

# timed_solve 997 [4;53;47;107;71;43];;
solution found: ((47*(71-43))-((53*4)+107))
solution found: ((47*(71-43))-((53*4)+107))
Configurations explored: 38352
Execution time: 0.256012s

# timed_solve 937 [16;10;25;11;30;40];;
no solution found
Configurations explored: 44241
Execution time: 0.309016s
```

### WITHOUT MEMO:
```
# timed_solve 937 [15;10;53;2;41;19];;
solution found: (((53*(19-2))+(41-15))+10)
solution found: (((53*(19-2))+(41-15))+10)
solution found: (((53*(19-2))+(41-15))+10)
solution found: ((53*(19-2))+((41-15)+10))
solution found: ((53*(19-2))+((41-15)+10))
solution found: ((53*(19-2))+((41-15)+10))
solution found: (((53*(19-2))-(15-10))+41)
solution found: (((53*(19-2))-(15-10))+41)
solution found: (((53*(19-2))-(15-10))+41)
solution found: ((53*(19-2))+(41-(15-10)))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: ((53*(19-2))+(41-(15-10)))
Configurations explored: 67248
Execution time: 0.712775s

# timed_solve 997 [4;53;47;107;71;43];;
solution found: (((47*(71-43))-(53*4))-107)
solution found: (((47*(71-43))-(53*4))-107)
solution found: ((47*(71-43))-((53*4)+107))
solution found: ((47*(71-43))-((53*4)+107))
Configurations explored: 61877
Execution time: 0.643151s

# timed_solve 937 [16;10;25;11;30;40];;
no solution found
Configurations explored: 74161
Execution time: 0.778926s
```

## ADDED SOLVED CONF REMOVAL.
### REMOVE SOLVED:
```
# timed_solve 937 [15;10;53;2;41;19;20;10];;
solution found: ((((20+15)+10)*19)+(41*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: (((41*20)-53)+((15+2)*10))
solution found: ((53*19)-(10*((20+2)-15)))
solution found: (((((41+20)-15)*19)+10)+53)
solution found: ((((41+20)-15)*19)+(53+10))
solution found: (((41+10)*(20-2))+19)
solution found: ((((53+20)*15)+(41*19))/2)
solution found: ((((20*19)+(53+15))*2)+41)
solution found: ((((53+20)*(15-2))+19)-(41-10))
Configurations explored: 577966
Execution time: 6.827676s

# timed_solve 937 [15;10;53;2;41;19];;
solution found: ((53*(19-2))+(41-(15-10)))
Configurations explored: 41352
Execution time: 0.344853s

# timed_solve 997 [4;53;47;107;71;43];;
solution found: ((47*(71-43))-((53*4)+107))
Configurations explored: 38352
Execution time: 0.355789s
```

### WITHOUT REMOVING:
```
# timed_solve 937 [15;10;53;2;41;19;20;10];;
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-53)+((15+2)*10))
solution found: (((41*20)-53)+((15+2)*10))
solution found: (((41*20)-53)+((15+2)*10))
solution found: (((41*20)-53)+((15+2)*10))
solution found: (((41*20)-53)+((15+2)*10))
solution found: (((41*20)-53)+((15+2)*10))
solution found: (((41*20)-53)+((15+2)*10))
solution found: (((41*20)-53)+((15+2)*10))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: (((41+10)*(53-(20+15)))+19)
solution found: (((41+10)*(53-(20+15)))+19)
solution found: (((41+10)*(53-(20+15)))+19)
solution found: (((41+10)*(53-(20+15)))+19)
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((((20+10)+15)*19)+(41*2))
solution found: ((((20+10)+15)*19)+(41*2))
solution found: ((((20+10)+15)*(41-19))-53)
solution found: ((((20+10)+15)*(41-19))-53)
solution found: ((((20+10)+15)*(41-19))-53)
solution found: ((((20+10)+15)*(41-19))-53)
solution found: ((((20+10)+15)*(41-19))-53)
solution found: ((((20+10)+15)*(41-19))-53)
solution found: ((53*19)-(10*((20+2)-15)))
solution found: ((53*19)-(10*((20+2)-15)))
solution found: ((53*19)-(10*((20+2)-15)))
solution found: (((41+10)*(20-2))+19)
solution found: (((41+10)*(20-2))+19)
solution found: (((41+10)*(20-2))+19)
solution found: (((41+10)*(20-2))+19)
solution found: (((41+10)*(20-2))+19)
solution found: (((41+10)*(20-2))+19)
solution found: (((41+10)*(20-2))+19)
solution found: (((41+10)*(20-2))+19)
solution found: (((41+10)*(20-2))+19)
solution found: (((41+10)*(20-2))+19)
solution found: (((41+10)*(20-2))+19)
solution found: (((41*15)+((20*19)-53))-(10/2))
solution found: (((41*15)+((20*19)-53))-(10/2))
solution found: ((((20*19)+(53+15))*2)+41)
solution found: ((((20*19)+(53+15))*2)+41)
Configurations explored: 578286
Execution time: 7.564586s

# timed_solve 937 [15;10;53;2;41;19];;
solution found: ((53*(19-2))+(41-(15-10)))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: ((53*(19-2))+(41-(15-10)))
Configurations explored: 41380
Execution time: 0.396202s

# timed_solve 997 [4;53;47;107;71;43];;
solution found: ((47*(71-43))-((53*4)+107))
solution found: ((47*(71-43))-((53*4)+107))
Configurations explored: 38352
Execution time: 0.391457s
```

## MERGED SOLUTION CHECKING AND SOLVED REMOVAL WITH MEMOISATION

### REMOVING SOLVED
```
# timed_solve 937 [15;10;53;2;41;19;20;10];;
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-53)+((15+2)*10))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: (((41+10)*(53-(20+15)))+19)
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((((20+10)+15)*19)+(41*2))
solution found: ((((20+10)+15)*(41-19))-53)
solution found: ((53*19)-(10*((20+2)-15)))
solution found: (((41+10)*(20-2))+19)
solution found: (((41*15)+((20*19)-53))-(10/2))
solution found: ((((20*19)+(53+15))*2)+41)
Configurations explored: 578271
Execution time: 2.174316s
```

### WITHOUT REMOVING SOLVED
```
timed_solve 937 [15;10;53;2;41;19;20;10];;
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-53)+((15+2)*10))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: (((41+10)*(53-(20+15)))+19)
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((((20+10)+15)*19)+(41*2))
solution found: ((((20+10)+15)*(41-19))-53)
solution found: ((53*19)-(10*((20+2)-15)))
solution found: (((41+10)*(20-2))+19)
solution found: (((41*15)+((20*19)-53))-(10/2))
solution found: ((((20*19)+(53+15))*2)+41)
Configurations explored: 578286
Execution time: 2.467325s
```

## Added "left identity" for sub and div

```
# timed_solve 937 [15;10;53;2;41;19];;
solution found: ((53*(19-2))+(41-(15-10)))
Configurations explored: 41218
Execution time: 0.137281s

# timed_solve 937 [15;10;53;2;41;19;20;10];;
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-53)+((15+2)*10))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: (((41+10)*(53-(20+15)))+19)
solution found: ((53*19)-((20+15)*2))
solution found: ((53*19)-((20+15)*2))
solution found: ((((20+10)+15)*19)+(41*2))
solution found: ((((20+10)+15)*(41-19))-53)
solution found: ((53*19)-(10*((20+2)-15)))
solution found: (((41+10)*(20-2))+19)
solution found: (((41*15)+((20*19)-53))-(10/2))
solution found: ((((20*19)+(53+15))*2)+41)
Configurations explored: 563259
Execution time: 2.032601s
```

## TESTING PROBLEMS WITH MANY SOLUTIONS:

```
# timed_solve 888 [3;4;6;8;12;24;37;74];;
..
(x9143 lines with many duplicates)
..
solution found: ((((24*(3*(74/37)))-4)+8)*6)
solution found: ((((24+12)*(3*(74/37)))+6)*4)
solution found: (((24*12)+8)*(6/((3*(74/37))-4)))
solution found: (74*12)
solution found: (37*24)
Configurations explored: 8246248
Execution time: 32.021062s
```

## REMOVING DUPE SOLUTION EXPRESSIONS AND DROPPING INTEGER LIST FROM MEMOISATION

### WITH HASHTBL
```
# timed_solve 888 [3;4;6;8;12;24;37;74];;
solution found: (((74-6)*12)+(24*3))
solution found: ((((74*24)-8)/(6/3))+4)
solution found: (((74-24)*(6*3))-12)
solution found: (((74*6)*3)-(37*12))
solution found: ((((74-24)*3)*6)-12)
solution found: (37*24)
solution found: (37*(12+(4*3)))
solution found: (37*(6*4))
solution found: (37*(8*3))
solution found: (37*(12*(6-4)))
solution found: (37*(12*(6/3)))
solution found: (37*(12*(8/4)))
solution found: (74*12)
solution found: ((74+37)*8)
solution found: ((74+37)*(12-4))
solution found: ((74+37)*(24/3))
solution found: (((24+(3-(74/37)))+12)*(6*4))
solution found: ((((24*3)-(74/37))+4)*12)
solution found: (((12*(4*3))+(8/(74/37)))*6)
solution found: (((24*3)+(74/37))*12)
solution found: (((24*3)+(74/37))*(8+4))
solution found: (((24*8)+(6*(3+(74/37))))*4)
solution found: (((24*12)+8)*(4-(3-(74/37))))
solution found: (((24*12)+8)*(6/((3*(74/37))-4)))
solution found: (((24*(3*(74/37)))+4)*6)
solution found: (((74*3)-(37*4))*12)
solution found: ((((74*6)/3)-37)*8)
solution found: ((37*3)*8)
solution found: ((37*4)*6)
solution found: ((37*6)*4)
solution found: ((37*8)*3)
solution found: ((37*12)*(6/3))
solution found: ((37*(6/3))*12)
solution found: ((74*4)*3)
solution found: ((74*6)*(8/4))
solution found: (((74+37)*4)*((24/3)-6))
solution found: (((74+37)*4)*(6/3))
solution found: (((74+37)*4)*((8*3)/12))
solution found: ((((74+37)/3)*4)*6)
solution found: (((37*12)/3)*6)
solution found: (((74*3)/6)*24)
solution found: (((74*8)/4)*6)
solution found: (((74*24)/8)*4)
solution found: (((74*24)/12)*6)
solution found: (((74*24)/(8*3))*12)
solution found: ((((74*6)*3)/12)*8)
solution found: ((((74*24)/3)/4)*6)
solution found: ((((74*24)/3)/8)*12)
solution found: ((((74*24)/8)/6)*(12+(4*3)))
solution found: ((74*24)/(6/3))
solution found: ((74*24)/(8/4))
solution found: (((74+37)*24)/(12-(6+3)))
solution found: (((74*3)*24)/6)
solution found: (((74*8)*6)/4)
solution found: (((74*8)*6)/(12/3))
solution found: (((74*24)*3)/6)
solution found: (((74*24)*4)/8)
solution found: (((74*24)*6)/12)
solution found: (((74*24)*6)/(4*3))
solution found: (((74*24)*12)/(8*3))
solution found: (((74*24)*(4+3))/(8+6))
solution found: ((((74+37)*3)*(24+8))/12)
solution found: ((((74+37)*3)*(24-8))/6)
solution found: ((((74*24)/12)*(8*3))/4)
Configurations explored: 5179864
Execution time: 8.070517s
```

### WITH List.sort_uniq
```
# timed_solve 888 [3;4;6;8;12;24;37;74];;
solution found: (((74-6)*12)+(24*3))
solution found: ((((74*24)-8)/(6/3))+4)
solution found: (((74-24)*(6*3))-12)
solution found: (((74*6)*3)-(37*12))
solution found: ((((74-24)*3)*6)-12)
solution found: (37*24)
solution found: (37*(12+(4*3)))
solution found: (37*(6*4))
solution found: (37*(8*3))
solution found: (37*(12*(6-4)))
solution found: (37*(12*(6/3)))
solution found: (37*(12*(8/4)))
solution found: (74*12)
solution found: ((74+37)*8)
solution found: ((74+37)*(12-4))
solution found: ((74+37)*(24/3))
solution found: (((24+(3-(74/37)))+12)*(6*4))
solution found: ((((24*3)-(74/37))+4)*12)
solution found: (((12*(4*3))+(8/(74/37)))*6)
solution found: (((24*3)+(74/37))*12)
solution found: (((24*3)+(74/37))*(8+4))
solution found: (((24*8)+(6*(3+(74/37))))*4)
solution found: (((24*12)+8)*(4-(3-(74/37))))
solution found: (((24*12)+8)*(6/((3*(74/37))-4)))
solution found: (((24*(3*(74/37)))+4)*6)
solution found: (((74*3)-(37*4))*12)
solution found: ((((74*6)/3)-37)*8)
solution found: ((37*3)*8)
solution found: ((37*4)*6)
solution found: ((37*6)*4)
solution found: ((37*8)*3)
solution found: ((37*12)*(6/3))
solution found: ((37*(6/3))*12)
solution found: ((74*4)*3)
solution found: ((74*6)*(8/4))
solution found: (((74+37)*4)*((24/3)-6))
solution found: (((74+37)*4)*(6/3))
solution found: (((74+37)*4)*((8*3)/12))
solution found: ((((74+37)/3)*4)*6)
solution found: (((37*12)/3)*6)
solution found: (((74*3)/6)*24)
solution found: (((74*8)/4)*6)
solution found: (((74*24)/8)*4)
solution found: (((74*24)/12)*6)
solution found: (((74*24)/(8*3))*12)
solution found: ((((74*6)*3)/12)*8)
solution found: ((((74*24)/3)/4)*6)
solution found: ((((74*24)/3)/8)*12)
solution found: ((((74*24)/8)/6)*(12+(4*3)))
solution found: ((74*24)/(6/3))
solution found: ((74*24)/(8/4))
solution found: (((74+37)*24)/(12-(6+3)))
solution found: (((74*3)*24)/6)
solution found: (((74*8)*6)/4)
solution found: (((74*8)*6)/(12/3))
solution found: (((74*24)*3)/6)
solution found: (((74*24)*4)/8)
solution found: (((74*24)*6)/12)
solution found: (((74*24)*6)/(4*3))
solution found: (((74*24)*12)/(8*3))
solution found: (((74*24)*(4+3))/(8+6))
solution found: ((((74+37)*3)*(24+8))/12)
solution found: ((((74+37)*3)*(24-8))/6)
solution found: ((((74*24)/12)*(8*3))/4)
Configurations explored: 5179864
Execution time: 8.070517s
```

## Testing impact of dropping expressions

```
# timed_solve 937 [15;10;53;2;41;19;20;10];;
solution found: (((41*20)-19)+((53+15)*2))
solution found: (((41*20)-53)+((15+2)*10))
solution found: (((41+10)*(53-(20+15)))+19)
solution found: ((((20*19)+(53+15))*2)+41)
solution found: ((53*19)-(10*((20+2)-15)))
Configurations explored: 474098
Execution time: 0.671511s

# timed_solve 937 [15;10;53;2;41;19];;
solution found: ((53*(19-2))+(41-(15-10)))
Configurations explored: 39007
Execution time: 0.051834s

# timed_solve 997 [4;53;47;107;71;43];;
solution found: ((47*(71-43))-((53*4)+107))
Configurations explored: 36753
Execution time: 0.053410s
```

## Fixed bug where not using index to pair up skips some solutions

```
# timed_solve 7 [3;3;1];;
solution found: ((3+3)+1)
Configurations explored: 20
Execution time: 0.000073s
```

## Fixed bug where DELETE function deletes all instead of first occurence

```
# timed_solve 95 [7;10;25];;
solution found: ((10*7)+25)
Configurations explored: 37
Execution time: 0.000116s

# timed_solve 15 [5;2;5];;
solution found: ((5*2)+5)
Configurations explored: 33
Execution time: 0.000227s

# timed_solve 194 [2;7;9;10];;
solution found: (((10*9)+7)*2)
Configurations explored: 500
Execution time: 0.001716s

# timed_solve 937 [15;10;53;2;41;19];;
solution found: (((53*(19-2))-(15-10))+41)
Configurations explored: 141801
Execution time: 0.241036s

# timed_solve 997 [4;53;47;107;71;43];;
solution found: ((47*(71-43))-((53*4)+107))
Configurations explored: 133341
Execution time: 0.216932s


# timed_solve 888 [3;4;6;8;12;24;37;74];;
solution found: ((37*12)+(74*6))
solution found: ((37*(24-(6-4)))+74)
solution found: ((37*(24-(8-6)))+74)
solution found: ((37*(24-(6/3)))+74)
solution found: ((37*(4*3))+(74*6))
solution found: ((74*6)+(37*12))
solution found: ((74*6)+(37*(4*3)))
solution found: (((37-6)*24)+(12*(4*3)))
solution found: (((12*(8+4))*6)+24)
solution found: (((12*(4*3))*6)+24)
solution found: (((12*(4*3))*(8-(74/37)))+24)
solution found: ((((6+3)*8)*12)+24)
solution found: ((((8+4)*6)*12)+24)
solution found: ((((12-(6/(74/37)))*8)*(4*3))+24)
solution found: ((((4*3)*6)*12)+24)
solution found: ((((12*(4*3))+8)*6)-24)
solution found: (((((4*3)*12)+8)*6)-24)
solution found: (((74-24)*(12+6))-(4*3))
solution found: (((74-24)*((4*3)+6))-12)
solution found: (37*24)
solution found: (37*(12+(4*3)))
solution found: (37*(12+(6*(24/(4*3)))))
solution found: (37*((4*3)+12))
solution found: (37*(((8*6)-12)-(4*3)))
solution found: (37*(6*4))
solution found: (37*(8*3))
solution found: (37*(12*(6-4)))
solution found: (37*(12*((6+4)-8)))
solution found: (37*(12*(6/3)))
solution found: (74*12)
solution found: (74*(8+4))
solution found: (74*((37-(4-3))-24))
solution found: (74*((8*(6/3))-4))
solution found: (74*(4*3))
solution found: (74*(24/((6+4)-8)))
solution found: ((37+(74/(6-4)))*12)
solution found: ((37+(74/(6/3)))*12)
solution found: ((74+37)*8)
solution found: ((74+37)*(12-4))
solution found: ((74+37)*(12-(24/6)))
solution found: ((74+37)*(24/3))
solution found: ((((74-12)-37)+(4*3))*24)
solution found: (((12*6)+(74/37))*(4*3))
solution found: (((12*(4*3))+(8/(74/37)))*6)
solution found: (((24*12)+8)*3)
solution found: (((24*12)+8)*(6/(74/37)))
solution found: (((24*((4*3)+6))+12)*(74/37))
solution found: (((37*6)+74)*3)
solution found: ((((24+3)*8)+6)*4)
solution found: ((((4*3)*6)+(74/37))*12)
solution found: ((((6*4)*12)+8)*3)
solution found: (((74/(6-4))+37)*12)
solution found: (((74/(6/3))+37)*12)
solution found: (((12*4)-(8+3))*24)
solution found: (((37*8)-74)*4)
solution found: (((74*8)-(37*(4*3)))*6)
solution found: (((74*(6-4))-37)*8)
solution found: (((74*(6/3))-37)*8)
solution found: ((((37-24)*(4*3))-8)*6)
solution found: ((37*8)*3)
solution found: ((37*8)*(12-(6+3)))
solution found: ((37*8)*((24+(4*3))/12))
solution found: ((37*12)*(8-6))
solution found: ((37*12)*((8+6)-(4*3)))
solution found: ((37*(6-4))*12)
solution found: ((37*(8-6))*12)
solution found: ((37*(8-6))*(4*3))
solution found: ((37*(12-(6+3)))*8)
solution found: ((37*(6/3))*12)
solution found: ((37*(8/4))*12)
solution found: ((74*(8/4))*6)
solution found: ((74/(6-4))*24)
solution found: ((74/(12/6))*24)
solution found: (((74+37)/3)*24)
solution found: (((37*12)/4)*8)
solution found: (((37*12)/6)*(4*3))
solution found: ((((74+37)*(4*3))/12)*8)
solution found: ((74*24)/(8-6))
solution found: ((74*24)/((8+6)-12))
solution found: (((37*(4*3))*12)/6)
solution found: (((74*24)*6)/12)
solution found: (((74*24)*6)/(4*3))
solution found: ((((74*24)/6)*12)/((4*3)-8))
Configurations explored: 32915851
Execution time: 81.578782s

# timed_solve 937 [15;10;53;2;41;19;20;10];;
solution found: (((((15*2)*19)-53)+10)+(41*10))
solution found: (((41*20)+(15+2))+(10*10))
solution found: ((((41+2)*19)+20)+(10*10))
solution found: ((((41+(15-10))*19)+10)+53)
solution found: (((((53+41)*10)-2)-20)+19)
solution found: (((53*(19-2))-(15-10))+41)
solution found: ((41*19)+(((15*10)+10)-2))
solution found: ((41*20)+((15-2)*(19-10)))
solution found: ((53*(19-2))+(41-(15-10)))
solution found: ((53*(19-(20/10)))+(41-(15-10)))
solution found: (((41+10)*(20-2))+19)
solution found: (((41+(15-10))*19)+(53+10))
solution found: (((41+(10/2))*19)+(53+10))
solution found: (((53-20)*19)+((41-10)*10))
solution found: (((53*19)+(15*2))-(10*10))
solution found: ((((53+10)*15)+2)-10)
solution found: (((((53-2)+41)*10)+19)-(20/10))
solution found: (((53*19)-20)-((10*10)/2))
solution found: ((((41+10)*19)-(20/10))-(15*2))
solution found: ((((53+41)*10)-(20-19))-2)
solution found: (((((53+15)-19)*20)-41)-2)
solution found: ((53*19)-((10*(15-10))+20))
solution found: ((53*19)-((((15*2)*20)/10)+10))
solution found: ((53*19)-((20+15)*2))
solution found: ((53*20)-(41*(2+(10/10))))
solution found: ((53*20)-(41*((15*2)/10)))
solution found: ((53*(19+10))-((15*2)*20))
solution found: (((41+10)*19)-((20+2)+10))
solution found: (((41+(19-10))*20)-(53+10))
solution found: (((53+41)*10)-((15*2)/10))
solution found: ((((15+10)+20)*(41-19))-53)
solution found: ((((53+(20-19))+41)*10)-(15-2))
solution found: (((41-(10-(20/10)))*(15*2))-53)
solution found: (((53-(((15*2)-20)/10))*19)-(41+10))
solution found: ((((20*10)-2)*(15-10))-53)
Configurations explored: 26977976
Execution time: 67.397327s
```


