# Algorithms
Implementing common programming algorithms in Prolog.

## Merge Lists
Given two sorted lists, there exists another list that contains all the elements from each list, sorted. (WIP)
```prolog
?- merged_lists([1,3,5], [2,4,6], [], L).
L = [6, 5, 4, 3, 2, 1] .
```
This is currently working, although in reverse sorting.
