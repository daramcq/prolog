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
link(e, b, 1).
link(f, b, 1).
link(g, b, 2).
link(h, b, 1).
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

### Find the Weighted Path between two nodes
At present we can just query if a path is available. The next step is to return a weighted path. After that, we can identify the lowest or highest weighted path between two nodes.
```prolog
?- weighted_path(a, c, []).
true .
```
