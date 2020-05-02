

state(State):-
    State = [player-[location-x, inventory-[torch, snorkel]],
             rooms-[room-[description-[this, is, a, place], items-[trowel]]]].

player_info(State, PlayerInfo) :-
    car(State, _-PlayerInfo).

inventory(State, Inventory) :-
    player_info(State, PlayerInfo),
    cdr(PlayerInfo, InfoTail),
    car(InfoTail, _-Inventory).

get_inventory(Inventory) :-
    state(S),
    inventory(S, Inventory).

loop :-
    repeat,
    prompt_input(InputList),
    parse_command(InputList, Action, Object),
    call(Action, Object).
    !.

car(List, Head) :-
    List = [Head|_].

cdr(List, Tail) :-
    List = [_|Tail].

parse_list(List, Action, Object) :-
    List = [Action|Tail],
    car(Tail, Object).

parse_command(X, Action, Object) :-
    parse_list(X, Action, Object).

move(X) :-
    write('You are moving '),
    write(X).

prompt_input(UserInputAtoms) :-
    ansi_format([bold, fg(white)], '[Game] >> ', []),
    read_line_to_string(user_input, UserInputString),
    string_lower(UserInputString, UserInputStringLower),
    atomic_list_concat(UserInputAtoms, ' ', UserInputStringLower).
    
