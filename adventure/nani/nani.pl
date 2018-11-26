:- dynamic here/1.
:- dynamic have/1.
:- dynamic location/2.
:- dynamic off/1.
:- dynamic door/3.
:- dynamic loc_list/2

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).
append([], X, X).

append([H|T1], X, [H|T2]) :-
    append(T1, X, T2).

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

open_door(Room) :-
    here(X),
    connected(X, Room),
    door(X, Room, closed),
    retract(door(X, Room, closed)),
    asserta(door(X, Room, open)),
    write('Door opened').

open_door(Room) :-
    here(X),
    connected(X, Room),
    door(X, Room, open),
    write('The door is open already!'), fail.

close_door(Room) :-
    here(X),
    connected(X, Room),
    door(X, Room, open),
    retract(door(X, Room, open)),
    asserta(door(X, Room, closed)),
    write('Door closed').

close_door(Room) :-
    here(X),
    connected(X, Room),
    door(X, Room, closed),
    write('The door is closed already!'), fail.

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
location(X, Y) :-
    loc_list(List, Y),
    member(X, List).

off(flashlight).

object(candle, red, small, 1).
object(apple, red, small, 1).
object(apple, green, small, 1).
object(table, blue, big, 50).

location_s(object(candle, red, small, 1), kitchen).
location_s(object(apple, red, small, 1), kitchen).
location_s(object(apple, green, small, 1), kitchen).
location_s(object(table, blue, big, 50), kitchen).
loc_list([apple, broccoli, crackers], kitchen).
loc_list([desk, computer], office).
loc_list([flashlight, envelope], desk).
loc_list([stamp, key], envelope).
loc_list(['washing machine'], cellar).
loc_list([nani], 'washing machine').
loc_list([], hall).

add_thing(NewThing, Container, [NewThing|OldList]) :-
    loc_list(OldList, Container).

put_thing(Thing, Place) :-
    retract(loc_list(List, Place)),
    asserta(loc_list([NewThing|List], Place)).

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

write_weight(1) :-
    write('1 pound').

write_weight(W) :-
    W > 1,
    write(W), write(' pounds').

list_things_s(Place) :-
    location_s(object(Thing, Color, Size, Weight), Place),
    write('A '), write(Size), tab(1),
    write(Color), tab(1),
    write(Thing), write(', weighing '),
    write_weight(Weight), nl, fail.

list_things_s(_).

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
    write(" is closed!"), nl,
    fail.

can_go(Place) :-
    here(X),
    write("You can't get to the "), write(Place),
    write(' from the '), write(X), nl,
    fail.

can_go(Place) :-
    here(Place),
    write("Already in the "), write(Place), write('!'),
    nl, fail.

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

can_take_s(Thing) :-
    here(Room),
    location_s(object(Thing, _, small, _), Room).

can_take_s(Thing) :-
    here(Room),
    location_s(object(Thing, _, big, _), Room),
    write('The '), write(Thing),
    write(' is too big to carry.'), nl, fail.

can_take_s(Thing) :-
    here(Room),
    not(location_s(object(Thing, _, _, _), Room)),
    write('There is no '), write(Thing),
    write(' here.'), nl, fail.

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
