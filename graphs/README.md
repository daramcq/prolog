# Graphs
Some work exploring graph calculations and search in Prolog.

## Bidirectional
A graph supporting bidirectional lookup
    ?- path_available(a, b, _).
    true.
    ?- path_available(a, d, []).
    true.
    ?- path_available(d, a, []).
    true.
    
## Weighted
