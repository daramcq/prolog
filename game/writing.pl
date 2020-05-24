:- module(writing, [write_list/1]).

write_list([]).
write_list([LastElement]) :-
    write(LastElement),
    write('.').

write_list([H|T]) :-
    write(H),
    write(', '),
    write_list(T).
