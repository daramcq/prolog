room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).

door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

location(desk, office).
location(apple, kitchen).
location(flashlight, desk).
location('washing machine', cellar).
location(nani, 'washing machine').
location(broccoli, kitchen).
location(crackers, kitchen).
location(computer, office).

edible(apple).
edible(crackers).

tastes_yucky(broccoli).

here(kitchen).

location_food(X, Y) :-
    location(X, Y), edible(X).

location_food(X, Y) :-
    location(X, Y), tastes_yucky(X).

connected(X, Y) :- door(X, Y).
connected(X, Y) :- door(Y, X).

list_things(Place) :-
    location(X, Place),
    tab(2),
    write(X),
    nl,
    fail.
list_things(_).

list_connected_rooms(Place) :-
    connected(Place, X),
    tab(2),
    write(X),
    nl,
    fail.
list_connected_rooms(_).

look :-
    here(Place),
    write('You are in the '), write(Place), write('.'),
    nl,
    write('You can see:'), nl,
    list_things(Place),
    write('You can go to:'), nl,
    list_connected_rooms(Place).

look_in(Thing) :-
    location(X, Thing),
    write(X), nl, fail.
look_in(_).
