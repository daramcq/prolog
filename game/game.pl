state(State):-
    State = [player-[location-x, inventory-[torch, snorkel]],
             rooms-[room-[description-[this, is, a, place], items-[trowel]]]].

player_info(State, PlayerInfo) :-
    car(State, _-PlayerInfo).


write_list([]).
write_list([LastElement]) :-
    write(LastElement),
    write('.').

write_list([H|T]) :-
    write(H),
    write(', '),
    write_list(T).

get_inventory(State, Inventory) :-
    player_info(State, PlayerInfo),
    cdr(PlayerInfo, InfoTail),
    car(InfoTail, _-Inventory).

inventory(State) :-
    get_inventory(State, Inventory),
    write_inventory(Inventory).

write_inventory([]):-
    write('You have nothing!').

write_inventory(Inventory):-
    write('Your inventory is: '),
    write_list(Inventory).

get_location(State, Location) :-
    player_info(State, PlayerInfo),
    car(PlayerInfo, _-Location).

play :-
    state(StartingState),
    loop(StartingState).

loop(State) :-
    repeat,
    prompt_input(InputList),
    Command =.. InputList,
    call(Command, State),
    loop(State).

car(List, Head) :-
    List = [Head|_].

cdr(List, Tail) :-
    List = [_|Tail].

parse_command(List, Action, Object) :-
    car(List, Action),
    cdr(List, Object).

move(X, State) :-
    get_location(State, CurrentLocation),
    write('You are in, '),
    write(CurrentLocation),
    write('.'),
    nl,
    write('You are moving '),
    write(X).

look(State) :-
    get_location(State, CurrentLocation),
    write('You are in '),
    write(CurrentLocation),
    write('.'),
    nl,
    write('You are looking').

prompt_input(UserInputAtoms) :-
    nl,
    ansi_format([bold, fg(white)], '[Game] >> ', []),
    read_line_to_string(user_input, UserInputString),
    string_lower(UserInputString, UserInputStringLower),
    atomic_list_concat(UserInputAtoms, ' ', UserInputStringLower).
    
