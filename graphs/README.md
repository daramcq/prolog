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
A weighted graph with function to extract the connected node with greatest edge weight.
```prolog
    ?- heaviestConnectingNode(b, X).
    X = d.
```
