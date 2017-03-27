plce(canyon).
place(forest).
place(flats).
place(cave).
place(town).
place(river).
place(dock).
place(island).

item(diamond).
item(house).
item(sword).
item(bow).
item(wood).
item(hat).
item(shovel).
item(arrow).
item(boat).
item(matches).
item(map).

lightable(wood).

person(saber).
person(archer).
person(elder).
person(fisherman).

want(sword,saber).
want(bow,archer).
want(map,elder).
want(boat,fisherman).

monster(wumpus).
monster(dragon).

location(wood,forest).
location(matches,forest).
location(sword,dock).
location(saber,dock).
location(bow, canyon).
location(arrow, canyon).
location(archer, canyon).
location(map, island).
location(house, town).
location(boat, town).
location(diamond, cave).
location(wumpus, forest).
location(dragon, cave).

path(canyon,forest).
path(forest,flats).
path(flats, cave).
path(cave, town).
path(town, dock).
path(town, river).
path(dock, canyon).
pathway(X,Y) :- path(X,Y).
pathway(X,Y) :- path(Y,X).

in(cave).
have(hat).
have(shovel).
have(wood).
have(matches).
have(diamond).

inventory :-
    have(Item),
    write("You have "),
    write(Item),
    nl,
    fail.
    inventory.

:- dynamic location/2.
:- dynamic in/1.

list_things(Place) :-
    location(X,Place),
    write(' '),
    write(X),
    nl,
    fail.
list_things(_).

list_paths(Place):-
    pathway(Place,X),
    write(' '),
    write(X),
    nl,
    fail.
list_paths(_).

look :-
    in(cave),
    have(light),
    write('You are in the '),
    write(cave),
    nl,
    write('You can see: '),
    nl,
    list_things(cave),
    write('You can go to: '),
    nl,
    list_paths(cave),
    retract(have(light)).
look :-
    in(cave),
    write('You are in cave '),
    nl,
    write('You can\'t see anything it\'s too dark'),
    nl.
look :-
    in(Place),
    write('You are in the '),
    write(Place),
    nl,
    write('You can see: '),
    nl,
    list_things(Place),
    write('You can go to: '),
    nl,
    list_paths(Place).

burn :-
    have(matches),
    lightable(Item),
    have(Item),
    retract(have(matches)),
    retract(have(Item)),
    asserta(have(light)),
    write('Burned! You have light now!'),
    nl.
burn :-
    have(light),
    write('Yo, it\'s getting warm!'),
    retract(have(light)).
burn :-
    write('Can\'t burn!'),
    nl.

take(Item) :-
    Item = sword,
    write('Owner: Hi! You! Stop steal my staff!'),
    nl.
take(Item) :-
    in(Place),
    retract(location(Item,Place)),
    asserta(have(Item)),
    write('taken'),
    nl,
    have(map),
    in(island),
    write('Map used, you will discover something in this area'),
    nl,
    asserta(item(axe)),
    retract(have(map)),
    asserta(location(axe,island)).
take(_).

trade :-
    in(Place),
    have(diamond),
    write('Deal! You got sword now!'),
    nl,
    asserta(have(sword)),
    retract(have(diamond)),
    retract(location(sword,Place)).
trade :-
    write('Go away, you are too poor to afford my sword!'),
    nl.

train(Person) :-
    want(Item, Person),
    have(Item),
    write('Good, thanks for your gift, I will train u!'),
    nl,
    retract(have(Item)),
    asserta(have(train)).
train(_):-
    write("Go away, stop hassling me!"),
    nl.

goto(Location) :-
    in(Place),
    have(boat),
    asserta(path(river,dock)),
    asserta(path(dock,island)),
    pathway(Place,Location),
    retract(in(Place)),
    asserta(in(Location)),
    look,
    retract(path(river,dock)),
    retract(path(dock,island)).
goto(Location) :-
    pathway(Place,Location),
    retract(in(Place)),
    asserta(in(Location)),
    look.
goto(_) :-
    write('Uhh ! I do not see how to get there.'),
    nl.


:- dynamic slain/1.

start :- game_over.
start :-
	write('>command: '),
	read(X),
        call(X),
	nl,
	start.

game_over :-
	slain(wumpus),
	write('Congratulations!  You\'ve won the game!').

ce(canyon).
place(forest).
place(flats).
place(cave).
place(town).
place(river).
place(dock).
item(diamond).
item(house).
item(sword).
item(bow).
item(wood).
item(hat).
item(shovel).
item(boat).
item(matches).
item(light).
lightable(wood).
person(saber).
person(archer).
person(elder).
monster(wumpus).
monster(dragon).
location(wood,forest).
location(matches,forest).
location(bow, canyon).
location(house, town).
location(boat, town).
location(diamond, cave).
location(wumpus, forest).
location(dragon, cave).
path(canyon,forest).
path(forest,flats).
path(flats, cave).
path(cave, town).
path(town, river).
path(dock, canyon).
pathway(X,Y) :- path(X,Y).
pathway(X,Y) :- path(Y,X).

in(cave).
have(hat).
have(shovel).
have(wood).
have(matches).

inventory :-
    have(Item),
    write("You have "),
    write(Item),
    nl,
    fail.
    inventory.

:- dynamic location/2.
:- dynamic in/1.

list_things(Place) :-
    location(X,Place),
    write(' '),
    write(X),
    nl,
    fail.
list_things(_).

list_paths(Place):-
    pathway(Place,X),
    write(' '),
    write(X),
    nl,
    fail.
list_paths(_).

look :-
    in(cave),
    have(light),
    write('You are in the '),
    write(cave),
    nl,
    write('You can see: '),
    nl,
    list_things(cave),
    write('You can go to: '),
    nl,
    list_paths(cave),
    retract(have(light)).
look :-
    in(cave),
    write('You are in cave '),
    nl,
    write('You can\'t see anything it\'s too dark'),
    nl.
look :-
    in(Place),
    write('You are in the '),
    write(Place),
    nl,
    write('You can see: '),
    nl,
    list_things(Place),
    write('You can go to: '),
    nl,
    list_paths(Place).

burn :-
    have(matches),
    lightable(Item),
    have(Item),
    retract(have(matches)),
    retract(have(Item)),
    asserta(have(light)),
    write('Burned! You have light now!'),
    nl,
    in(cave),
    look.
burn :-
    have(light),
    write('Yo, it\'s getting warm!'),
    retract(have(light)).
burn :-
    write('Can\'t burn!'),
    nl.

take(Item) :-
    in(Place),
    retract(location(Item,Place)),
    asserta(have(Item)),
    write('taken'), nl.

goto(Location) :-
    in(Place),
    have(boat),
    asserta(path(river,dock)),
    pathway(Place,Location),
    retract(in(Place)),
    asserta(in(Location)),
    look,
    retract(path(river,dock)).
goto(Location) :-
    pathway(Place,Location),
    retract(in(Place)),
    asserta(in(Location)),
    look.
goto(_) :-
    write('Uhh ! I do not see how to get there.'),
    nl.


factorial(Num, Result) :-
    Num > 0,
    Result1 is Result * Num,
    Num1 is Num - 1,
    factorial(Num1, Result1).

:- dynamic slain/1.

start :- game_over.
start :-
	write('>command: '),
	read(X),
        call(X),
	nl,
	start.

game_over :-
	slain(wumpus),
	write('Congratulations!  You\'ve won the game!').
ace(canyon).
place(forest).
place(flats).
place(cave).
place(town).
place(river).
place(dock).
item(diamond).
item(house).
item(sword).
item(bow).
item(wood).
item(hat).
item(shovel).
lightable(woord).
person(saber).
person(archer).
person(elder).
monster(wumpus).
monster(dragon).
location(wood,forest).
location(bow, canyon).
location(house, town).
location(diamond, cave).
location(wumpus, forest).
location(dragon, cave).
path(canyon,forest).
path(forest,flats).
path(flats, cave).
path(cave, town).
path(town, river).
path(river, dock).
path(dock, canyon).
pathway(X,Y) :- path(X,Y).
pathway(X,Y) :- path(Y,X).

in(canyon).
have(hat).
have(shovel).

inventory :-
    have(Item),
    write("You have "),
    write(Item),
    nl,
    fail.
    inventory.

:- dynamic location/2.
:- dynamic in/1.

list_things(Place) :-
    location(X,Place),
    write(' '),
    write(X),
    nl,
    fail.
list_things(_).

list_paths(Place):-
    pathway(Place,X),
    write(' '),
    write(X),
    nl,
    fail.
list_paths(_).

look :-
    in(Place),
    write('You are in the '),
    write(Place),
    nl,
    write('You can see: '),
    nl,
    list_things(Place),
    write('You can go to: '),
    nl,
    list_paths(Place).

take(Item) :-
    in(Place),
    retract(location(Item,Place)),
    asserta(have(Item)),
    write('taken'), nl.

goto(Location) :-
    in(Place),
    pathway(Place,Location),
    retract(in(Place)),
    asserta(in(Location)),
    look.
goto(_) :-
    write('Uhh ! I do not see how to get there.'),
    nl.


factorial(Num, Result) :-
    Num > 0,
    Result1 is Result * Num,
    Num1 is Num - 1,
    factorial(Num1, Result1).

:- dynamic slain/1.

start :- game_over.
start :-
	write('>command: '),
	read(X),
        call(X),
	nl,
	start.

game_over :-
	slain(wumpus),
	write('Congratulations!  You\'ve won the game!').
