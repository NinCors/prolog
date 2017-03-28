/*author: Chiyu Cheng
 *
 *Extra three features:
 *1. Add the status fact to record the health status of player,
 *   if play lose the battle with monster, then the status of
 *   he/she will become injured. Player can't fight with monster
 *   again if the status is injured and he/she need fight a place
 *   to heal.
 *
 *2. Add the function to restore the status to health. The option is
 *   go to the house in town, use 'sleep.' command to restore
 *   health. play can fight with monster again after healed.
 *
 *3. Add player data, user can input their name, title, and class in the
 *   beginning of game. Player can use 'playerData' command to check
 *   their status
 */

place(island).

place(canyon).
place(forest).
place(flats).
place(cave).
place(town).
place(river).
place(dock).
place(shop).
place(foothills).
place(sinkhole).
place(mountain).
place(woods).

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
item(element).

lightable(hay).

person(saber).
person(archer).
person(owner).
person(fisherman).

want(sword,saber).
want(bow,archer).
want(map,owner).
want(boat,fisherman).

monster(wumpus).
monster(dragon).

location(hay,woods).

location(matches, foothills).
location(wumpus, forest).

location(fisherman,dock).

location(bow, canyon).
location(archer, canyon).

location(arrow, mountain).

location(map, island).

location(saber, town).
location(house, town).
location(boat, town).

location(owner, shop).
location(sword, shop).

location(diamond, cave).
location(dragon, cave).

path(dock,town).
path(town,shop).
path(town, flats).
path(town, woods).
path(woods, forest).
path(flats, sinkhole).
path(sinkhole, cave).
path(flats, canyon).
path(flats, foothills).
path(foothills, mountain).

pathway(X,Y) :- path(X,Y).
pathway(X,Y) :- path(Y,X).

status(health).
name(n).
title(n).
class(n).
in(town).
have(hat).
have(shovel).
have(hay).
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
:- dynamic status/1.
:- dynamic slain/1.
:- dynamic name/1.
:- dynamic title/1.
:- dynamic class/1.

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

playerData :-
    status(S),
    name(N),
    title(T),
    class(C),
    write('Player: The '),
    write(C),
    write(' - '),
    write(T),
    write(' '),
    write(N),
    nl,
    write('Player status: '),
    write(S),
    nl.
playerData :-
    nl.

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
look.



burn :-
    have(matches),
    lightable(Item),
    have(Item),
    retract(have(matches)),
    retract(have(Item)),
    asserta(have(light)),
    in(cave),
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
    write('Good, you have the thing I want, I will train u!'),
    nl,
    asserta(have(train)).
train(_):-
    write("Go away, stop hassling me!"),
    nl.

checkWeapon(Check):-
    have(sword),
    Check is 1.
checkWeapon(Check):-
    have(bow),
    have(arrow),
    Check is 1.
checkWeapon(Check):-
    have(axe),
    Check is 1.

fight(_) :-
    status(S),
    S = injured,
    write('You got injured, you need restore your health!').
fight(Monster) :-
    have(train),
    checkWeapon(Check),
    Check = 1,
    write("Good, you have both trainning and weapon! Let's fight with "),
    write("Monster"),
    nl,
    asserta(slain(Monster)).

fight(_) :-
    write('You have nothing, you got badly injured!'),
    nl,
    retract(status(health)),
    asserta(status(injured)).


player :-
    have(data).
player :-
    write("Welcome to wumpus world!"),
    nl,
    write("What's your name?"),
    nl,
    read(Y),
    retract(name(n)),
    asserta(name(Y)),
    write("What's your title?"),
    nl,
    read(YY),
    retract(title(n)),
    asserta(title(YY)),
    write("What's your class?"),
    nl,
    read(XX),
    retract(class(n)),
    asserta(class(XX)),
    nl,
    asserta(have(data)),
    write('Ok,data record!'),
    nl,
    look,nl.
player :-
    nl.

sleep :-
    in(town),
    write('Having a good sleep, all the pain will be disappear after you wake up!'),
    nl,
    retract(status(injured)),
    asserta(status(health)).
sleep :-
    write('You need find a place with house!!'),
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

start :- game_over.
start :-
        player,
	write('>command: '),
	read(X),
        call(X),
	nl,
	start.

game_over :-
	slain(wumpus),
	write('Congratulations!  You\'ve won the game!').





























