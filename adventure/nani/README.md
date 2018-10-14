# Nani Adventure Game
The *Nani* game from Dennis Merritt's _Adventure in Prolog_. 

## Looking Around
```prolog
?- look.
You are in the kitchen.
You can see:
  apple
  broccoli
  crackers
You can go to:
  office
  cellar
  dining room
```
## Picking up Items
```prolog
?- take(broccoli).
broccoli taken
```

## Moving Around
```prolog
?- goto('office').
You are in the office.
You can see:
  desk
  computer
You can go to:
  hall
  kitchen
```
