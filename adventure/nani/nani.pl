:- dynamic here/1.
:- dynamic have/1.
:- dynamic location/2.

here(kitchen).

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

goto(Place) :-
    can_go(Place),
    move(Place),
    look.

can_go(Place) :-
    here(X),
    connected(X, Place).

can_go(Place) :-
    here(X),
    write("You can't get to the "), write(Place),
    write(' from the '), write(X), nl,
    fail.

move(Place) :-
    retract(here(_)),
    asserta(here(Place)).

take(Thing) :-
    can_take(Thing),
    take_object(Thing).

can_take(Thing) :-
    here(Place),
    location(Thing, Place).

can_take(Thing) :-
    write('There is no'), write(Thing),
    write(' here.'),
    nl, fail.

take_object(Thing) :-
    retract(location(Thing, _)),
    asserta(have(Thing)),
    write(Thing), write(' taken'), nl.
