loop :-
    repeat,
    prompt_input(InputList),
    parse_command(InputList, Action, Object),
    call(Action, Object).
    !.

parse_object(List, Object) :-
    List = [Object|_].

parse_list(List, Action, Object) :-
    List = [Action|Tail],
    parse_object(Tail, Object).

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
    
