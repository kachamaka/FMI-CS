% gen_bin_tree(Tree) :- 
%     gen_nat_quad_tuple(N, Min, Max, K),
%     Height is N - 1,
%     gen_bin_tree(Height, Min, Max, K, Tree).

% gen_nat_quad_tuple(A, B, C, D) :-
%     gen_nat(N),
%     gen_KS(4, N, [A, B, C, D]).

% gen_KS(1, S, [S]).
% gen_KS(K, S, [H | T]) :-
%     K > 1,
%     K1 is K - 1,
%     between(0, S, H),
%     SH is S - H,
%     gen_KS(K1, SH, T).

% gen_nat(0).
% gen_nat(N) :- gen_nat(K), N is K + 1.

% gen_bin_tree(Height, Min, Max, K, Tree) 

% ------------------------------------------------------------------------------------------------------------------------------------

nat(0).
nat(N) :- nat(K), N is K + 1.

gen_prime(P) :- 
    nat(P), 
    P > 1, 
    is_prime(P).

between(A, B, A) :- A =< B.
between(A, B, K) :- A < B, A1 is A + 1, between(A1, B, K).

is_prime(P) :- 
    P > 1, 
    P1 is P - 1,
    not((
        between(2, P1, D),
        P mod D =:= 0    
    )).

q(I, K) :- 
    primes(I, PS), 
    length(PS, K).

check(X) :- between(1, X, I), q(I, K), X =:= I + K.

primes(I, PS) :-
    I1 is I - 1,
    range(2, I1, L),
    filter(L, PS).

range(A, B, []) :- A > B.
range(A, B, [A | T]) :- A =< B, A1 is A + 1, range(A1, B, T).

filter([], []).
filter([N | NS], T) :- not(condition(N)), filter(NS, T).
filter([N | NS], [N | T]) :- condition(N), filter(NS, T).

condition(X) :- X mod 6 =:= 1, is_prime(X).


