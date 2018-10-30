link(a, b, 1).
link(c, b, 2).
link(d, b, 3).
link(d, c, 1).
link(a, d, 1).
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

weighted_path(X, Y, _, WeightedPath, FinalPath) :-
    connected(X, Y, W),
    FinalPath = [(X-Y)-W|WeightedPath].

weighted_path(X, Y, Trace, WeightedPath, FinalPath) :-
    connected(X, Z, W),
    not(member(Z, Trace)),
    weighted_path(Z, Y, [X|Trace],
                  [(X-Z)-W|WeightedPath],
                  FinalPath).

list_empty([]) :- true.
list_empty([_|_]) :- false.
list_not_empty([_|_]) :- true.
split_weight((_-_)-W, W).

total_path_weight([PathHead|PathTail], WeightList, FinalWeight) :-
    list_not_empty(PathTail),
    split_weight(PathHead, W),
    total_path_weight(PathTail, [W|WeightList], FinalWeight).

total_path_weight([Head|Tail], WeightList, FinalWeight) :-
    list_empty(Tail), split_weight(Head, W),
    sumlist([W|WeightList], FinalWeight).

weigh_path(X, Y, Path, Weight) :-
    weighted_path(X, Y, [], [], Path),
    total_path_weight(Path, [], Weight).
