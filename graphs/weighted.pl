link(a, b, 1).
link(c, b, 2).
link(d, b, 3).
link(e, b, 1).
link(f, b, 1).
link(g, b, 2).
link(h, b, 1).
link(c, d, 1).
link(a, f, 1).
link(f, g, 1).

connected(X, Y) :- link(X, Y, _).
connected(X, Y) :- link(Y, X, _).
connected(X, Y, W) :- link(X, Y, W).
connected(X, Y, W) :- link(Y, X, W).

reverse([], []).
reverse([H|T], R) :-
    reverse(T, RTemp), append(RTemp, [H], R).

% Find all the connecting nodes and their weights
linkedNodes(X, L) :-
    findall(W-Y, connected(Y, X, W), L).

% Sort the connecting nodes by weight
weightedNodes(X, SP) :-
    linkedNodes(X, L), keysort(L, SPAsc), reverse(SPAsc, SP).

transpose(X-Y, Y-X).
splitKey(X-_, X).

heaviestConnectingNode(X, Y) :-
    weightedNodes(X, SP), SP = [HP|_],
    transpose(HP, H), splitKey(H, Y).

negation(X, Y) :-
    Y is -(0, X).

pairNegation(X-Y, P):-
    negation(X, KN),
    P = KN-Y.

negationWeightedNodes(X, SP) :-
    linkedNodes(X, L),
    maplist(pairNegation, L, NP),
    keysort(NP, NSP),
    maplist(pairNegation, NSP, SP).

heaviestNodeViaNegation(X, Y) :-
    negationWeightedNodes(X, SP),
    SP = [HP|_], transpose(HP, H),
    splitKey(H, Y).

path_available(X, Y, _) :- connected(X, Y).

path_available(X, Y, Steps) :-
    connected(X, Z),
    not(member(Z, Steps)),
    path_available(Z, Y, [X|Steps]).

write_list([]).
write_list([H|T]) :-
    write(H), write(', '), write_list(T).

define_path(X, Y) :-
    path_available(X, Y, Steps),
    write_list(Steps).

weighted_path(X, Y, WeightedPath) :-
    connected(X, Y, W),
    WeightedPath = [Y-W].
