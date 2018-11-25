:- dynamic here/1.
:- dynamic have/1.
:- dynamic location/2.
:- dynamic off/1.

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

door(office, hall, open).
door(kitchen, office, closed).
door(hall, 'dining room', closed).
door(kitchen, cellar, closed).
door('dining room', kitchen, closed).

open(door(RoomA, RoomB)) :-
    retract(door(RoomA, RoomB, closed)),
    asserta(door(RoomA, RoomB, open)),
    write('Door opened').

closed(door(RoomA, RoomB)) :-
    retract(door(RoomA, RoomB, open)),
    asserta(door(RoomA, RoomB, closed)),
    write('Door closed').

location(desk, office).
location(apple, kitchen).
location(flashlight, desk).
location(envelope, desk).
location(stamp, envelope).
location(key, envelope).
location('washing machine', cellar).
location(nani, 'washing machine').
location(broccoli, kitchen).
location(crackers, kitchen).
location(computer, office).
off(flashlight).

is_contained_in(T1, T2) :-
    location(T1, T2).

is_contained_in(T1, T2) :-
    location(T1, X), is_contained_in(X, T2).

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
    connected(X, Place),
    door(X, Place, open).

can_go(Place) :-
    here(X),
    connected(X, Place),
    door(X, Place, closed),
    write("The door between the "), write(X),
    write(" and the "), write(Place),
    write(" is closed!"),
    fail.

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
    is_contained_in(Thing, Place).

can_take(Thing) :-
    write('There is no'), write(Thing),
    write(' here.'),
    nl, fail.

take_object(Thing) :-
    retract(location(Thing, _)),
    asserta(have(Thing)),
    write(Thing), write(' taken'), nl.

put(Thing) :-
    retract(have(Thing)),
    here(Place),
    asserta(location(Thing, Place)).

inventory :-
    write('You have:'), nl,
    have(Thing), write(Thing), nl, fail.

turn_on(Thing) :-
    off(Thing),
    retract(off(Thing)),
    asserta(on(Thing)),
    write(Thing), write(' on!').

turn_on(Thing) :-
    on(Thing),
    write(Thing), write(' already on!').

turn_on(_) :-
    write("You can't turn that on!"), fail.

turn_off(Thing) :-
    on(Thing),
    retract(on(Thing)),
    asserta(off(Thing)),
    write(Thing), write(' off!').

turn_off(Thing) :-
    off(Thing),
    write(Thing), write(' already off!').

turn_off(_) :-
    write("You can't turn that off!").
