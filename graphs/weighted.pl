link(a, b, 1).
link(c, b, 2).
link(d, b, 3).
link(e, b, 1).
link(f, b, 1).

connected(X, Y) :- link(X, Y, _).
connected(X, Y) :- link(Y, X, _).
connected(X, Y, W) :- link(X, Y, W).
connected(X, Y, W) :- link(Y, X, W).

reverse([],[]).
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
