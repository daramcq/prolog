link(a, b, 1).
link(c, b, 2).
link(d, b, 3).
link(e, b, 1).
link(f, b, 1).

connected(X, Y) :- link(X, Y, _).
connected(X, Y) :- link(Y, X, _).
connected(X, Y, W) :- link(X, Y, W).
connected(X, Y, W) :- link(Y, X, W).

% Find all the connecting nodes and their weights
linkedNodes(X, L) :-
    findall([Y, W], connected(Y, X, W), L).
