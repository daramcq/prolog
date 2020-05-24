:- use_module(writing). 

starting_state(State) :-
    State = state{
                player_info: player_info{
                                 location: myroom,
                                 inventory: [torch, snorkel]
                             },
                rooms: rooms{
                           myroom: myroom{
                                       description: "This is a beautiful room",
                                       items: [trowel, key],
                                       objects: objects{
                                                    locked_door: locked_door{
                                                                     name: door,
                                                                     description: "A locked door"
                                                                 },
                                                    table: table{
                                                               name: table,
                                                               description: "A beautiful wooden table"
                                                           }
                                                }
                                   }
                       }
            }.

remove_object(Object, Room, State, NewState) :-
    write(Object),
    del_dict(Object, State.rooms.Room.objects, _, MRNO),
    NewState = State.put(rooms/Room/objects, MRNO).

unlock_door(State, NewState) :-
    remove_object(locked_door, State),
    add_object(unlocked_door, State, NewState).

interaction_effects(use, key, locked_door, [unlock_door]).

do_interaction(Verb-Item-Object-ObjectState, State, NewState) :-
    valid_interaction(Verb-Item-Object, State),
    interaction_effects(Verb-Item-Object, Effects),
    do_effects(Effects, State, NewState),
    effect_results(Effects, Results),
    write_results(Results).

player_info(State, PlayerInfo) :-
    PlayerInfo = State.get(player_info).

current_room(State, Room) :-
    PlayerLocation = State.get(player_info).get(location),
    Room = State.get(rooms).get(PlayerLocation).

item_in_current_room(State, Item) :-
    current_room(State, Room),
    RoomItems = Room.get(items),
    member(Item, RoomItems).

add_item_to_inventory(State, Item, NewState) :-
    get_inventory(State, Inventory),
    append(Inventory, [Item], NewInventory),
    NewState = State.put(player_info/inventory, NewInventory).

player_location(State, Location) :-
    Location = State.get(player_info).get(location).                   

take(Item, State, NewState) :-
    item_in_current_room(State, Item),
    add_item_to_inventory(State,
                          Item,
                          StateWithModifiedInventory),
    remove_item_from_room(StateWithModifiedInventory,
                          Item,
                          NewState),
    write('You took the '),
    write(Item).

take(Item, State, _) :-
    item_in_current_room(State, Item);
    write("That's not in the room").

remove_item_from_room(State, Item, NewState) :-
    player_info(State, PlayerInfo),
    RoomName = PlayerInfo.location,
    current_room(State, Room),
    RoomItems = Room.get(items),
    select(Item, RoomItems, NewRoomItems),
    NewState = State.put(rooms/RoomName/items, NewRoomItems).

get_inventory(State, Inventory) :-
    player_info(State, PlayerInfo),
    Inventory = PlayerInfo.inventory.

inventory(State, NewState) :-
    NewState = State,
    get_inventory(State, Inventory),
    write_inventory(Inventory).

write_inventory([]):-
    write('You have nothing!').

write_inventory(Inventory):-
    write('Your inventory is: '),
    write_list(Inventory).

get_location(State, Location) :-
    player_info(State, PlayerInfo),
    Location = PlayerInfo.location.

play :-
    starting_state(StartingState),
    loop(StartingState).

loop(State) :-
    repeat,
    prompt_input(InputList),
    Command =.. InputList,
    call(Command, State, NewState),
    loop(NewState).

car(List, Head) :-
    List = [Head|_].

parse_command(List, Action, Object) :-
    car(List, Action),
    last(List, Object).

move(X, State) :-
    write('You are moving '),
    write(X).

look(State, NewState) :-
    get_location(State, RoomName),
    current_room(State, Room),
    NewState = State,
    RoomItems = Room.get(items),
    Description = Room.get(description),
    write('You are in '),
    write(RoomName),
    write('.'),
    nl,
    write(Description),
    write('. '),
    write('There is '),
    write_list(RoomItems).

prompt_input(UserInputAtoms) :-
    nl,
    ansi_format([bold, fg(white)], '[Game] >> ', []),
    read_line_to_string(user_input, UserInputString),
    string_lower(UserInputString, UserInputStringLower),
    atomic_list_concat(UserInputAtoms, ' ', UserInputStringLower).
