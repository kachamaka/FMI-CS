nat(0).
nat(N) :- nat(K), N is K + 1.

permutate([], []).
permutate([H | T], P) :- permutate(T, Q), insert(H, Q, P).

insert(X, L, R) :- append(P, S, L), append(P, [X | S], R).

append([], L, L).
append([H | T], L, [H | R]) :- append(T, L, R).

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T). 

between(A, B, A) :- A =< B.
between(A, B, K) :- A < B, A1 is A + 1, between(A1, B, K).

gen_KS(1, S, [S]).
gen_KS(K, S, [H | T]) :-
    K > 0,    
    between(0, S, H),
    S1 is S - H,
    K1 is K - 1,
    gen_KS(K1, S1, T).

subsequence([], []).
subsequence([H | T], [H | S]) :- subsequence(T, S).
subsequence([_ | T], S) :- subsequence(T, S).

len([], 0). 
len([_ | T], N) :- len(T, K), N is K + 1.

% ------------------------------------------------------------------------------------------------------------------------------

