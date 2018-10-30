# Graphs
Some work exploring graph calculations and search in Prolog.

## Bidirectional
A graph supporting bidirectional lookup, using a recursive search with backtrace.
```prolog
    ?- path_available(a, b, _).
    true.
    ?- path_available(a, d, []).
    true.
    ?- path_available(d, a, []).
    true.
```
    
## Weighted
A weighted graph with rules to extract the connected node with greatest edge weight. Given links between nodes as such:
```prolog
link(a, b, 1).
link(c, b, 2).
link(d, b, 3).
```
We can propose a rule to return the node with the heaviest connecting edge.
```prolog
    ?- heaviestConnectingNode(b, X).
    X = d.
```
This implementation sorts and reverses a list of Pairs representing weighted edges to pull the head element from the list. The same rule is also implemented using negation of the Pairs instead of reversal.
```prolog
?- heaviestNodeViaNegation(b, X).
X = d.
```

### Weighted Path between two nodes
Given two nodes connected via a path of nodes and weighted edges, we may wish to identify the weight of a given path between them.
```prolog
?- weighted_path(a, c, [], [], L).
L = [b-c-2, a-b-1] ;
L = [d-c-1, c-d-1, b-c-2, a-b-1] ;
L = [d-c-1, b-d-3, a-b-1] ;
L = [d-c-1, a-d-1] ;
L = [b-c-2, d-b-3, a-d-1] ;
L = [b-c-2, c-b-2, d-c-1, a-d-1] ;
false.
```
