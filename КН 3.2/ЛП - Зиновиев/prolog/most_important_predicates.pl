:- use_module(library(clpfd)).


nat(N) :- N #= 0 ; nat(N - 1).

mem(A, [A|_]).
mem(A, [_|X]) :- mem(A, X).

app([], X, X).
app([A|X], Y, [A|Z]) :- app(X, Y, Z).

perm([], []).
perm([A|X], Z) :- perm(X, Y), app(Y1, Y2, Y), app(Y1, [A|Y2], Z).

len([], N) :- N #= 0.
len([_|X], N) :- N #>= 0, len(X, N - 1).

nth([A|_], N, A) :- N #= 1.
nth([_|X], N, A) :- N #>= 1, N #= N1 + 1, nth(X, N1, A). 

fact(N, F) :- N #= 0, F #= 1.
fact(N, F) :- N #>= 0, N #= N1 + 1, F #= F1 * N, fact(N1, F1).

pairs([A,B]) :- nat(N), [A, B] ins 0..N, label([A, B]).

prime(X) :- X #>= 2, not((Y #>= 2, Y #< X, X #= _*Y, label([Y]))).

ssort(X, Y) :- perm(X, Y), forall(app(_, [A, B | _], Y), A #=< B).

subsequence([], []).
subsequence([A|X], [A|Y]) :- subsequence(X, Y).
subsequence(X, [_|Y]) :- subsequence(X, Y).

subset(X, Y) :- forall(mem(A, X), mem(A, Y)). 

subset2(_,_,[]).
subset2(X, Y, [A|Z]) :-
        mem(A, X), not(mem(A, Y)), % A in X\Y
        subset2(X, [A|Y], Z).