link(a, b).
link(b, c).
link(c, d).
link(d, e).
link(e, f).
link(g, h).
link(h, i).

connected(X, Y) :- link(X, Y).
connected(X, Y) :- link(Y, X).

path_available(X, Y, _) :- connected(X, Y).

path_available(X, Y, Steps):-
    connected(X, Z),
    not(member(Z, Steps)),
    path_available(Z, Y, [X|Steps]).
