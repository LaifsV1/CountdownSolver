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