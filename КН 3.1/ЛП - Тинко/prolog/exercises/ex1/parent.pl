female(mary).
female(sandra).
female(juliet).
female(lisa).

male(peter).
male(paul).
male(john).
male(bob).
male(harry).

parent(bob, lisa).
parent(bob, paul).
parent(bob, mary).
parent(juliet, lisa).
parent(juliet, paul).
parent(juliet, mary).
parent(peter, harry).
parent(lisa, harry).

parent(mary, john).
parent(mary, sandra).
parent(chris, john).
parent(chris, sandra).

% X is Y's mother
mother(X, Y) :- parent(X, Y), female(X).

% X is Y's brother
brother(X, Y) :- male(X), mother(Z, X), mother(Z, Y), X \= Y.

sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

grandmother(X, Y) :- female(X), grandparent(X, Y).

cousin(X, Y) :- grandmother(Z, X), grandmother(Z, Y), not(sibling(X, Y)), X \= Y.

