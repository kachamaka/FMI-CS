% gen_KS(K, S, L)
gen_KS(1, S, [S]).
gen_KS(K, S, [H | T]) :- 
    K > 0, 
    between(0, S, H),
    N is S - H,
    K1 is K - 1,
    gen_KS(K1, N, T).

nat(0).
nat(N) :- nat(K), N is K + 1.

between(A, B, A) :- A =< B.
between(A, B, K) :- A < B, A1 is A + 1, between(A1, B, K).

gen_pair(A, B) :- 
    nat(N),
    gen_KS(2, N, [A, B]).

% gen_fin_seq_Nat(L) : L is in union (k in N_+) N^k
gen_fin_seq_Nat(L) :-
    gen_pair(K, S),
    gen_KS(K, S, L).

% gen_fin_subset_Nat(S)
gen_fin_subset_Nat([]).
gen_fin_subset_Nat(S) :-
    gen_fin_seq_Nat(S),
    encodes_subset(S).

encodes_subset([]).
encodes_subset([_]).
encodes_subset([A, B | T]) :-
    A < B,
    encodes_subset([B | T]).

encodes_subset_not(L) :-
    not((append(_, [A, B | _], L), A >= B)).

append([], X, X).
append([H | T], L, [ H | R]) :- append(T, L, R).

% gen_ar_prog(P)
gen_ar_prog([]).
gen_ar_prog(P) :-
    nat(N),
    gen_KS(3, N, [L, K, M]),
    L > 0,
    int(K, A0),
    int(M, D),
    gen_ar_prog(L, A0, D, P).

% gen_ar_prog([]).
% gen_ar_prog(P) :-
%     nat(N).
%     gen_KS(3, N, [L, A0, D]),
%     L > 0,
%     gen_ar_prog(L, A0, D, P).

% gen_ar_prog(L, A0, D, P) :  L length, A0 start, D step, P prog
gen_ar_prog(1, A0, 0, [A0]).
gen_ar_prog(L, A0, D, P) :-
    L > 1,
    gen_ar_prog_with_rec(L, A0, D, P).

gen_ar_prog_with_rec(1, A0, _, [A0]).
gen_ar_prog_with_rec(L, A0, D, [A0 | P]) :-
    L > 1,
    L1 is L - 1,
    A1 is A0 + D,
    gen_ar_prog_with_rec(L1, A1, D, P).

% int(N, Z) : if N = 0 then Z = 0 else Z is in {N, -N}

int(0, 0).
int(N, N) :- N > 0.
int(N, Z) :- N > 0, Z is -N.


% q(A, [X, Y], [Z, U]) : given A nat generate [X, Y], [Z, U] 
% which represents rational numbers: Y > X > 0, Z > U > 0
% and (X / Y) * (Z / U) = 2
%  X + Z < A
% X * Z = 2 * Y * U
% q(A,)

gcd(0, B, B).
gcd(A, B, D) :-
    A > 0,
    R is B mod A,
    gcd(R, A, D).


% gen_in_circle([XC, YC], R, [X, Y])
% given integers XC, YC, R, R > 0
% gen X, Y:
% (X, Y) is point inside circle with center (XC, YC) and radius R

gen_in_square(R, A, B) :-
    MR is -R,
    between(MR, R, A),
    between(MR, R, B).

gen_in_circle_00(R, A, B) :-
    gen_in_square(R, A, B),
    A^2 + B^2 =< R^2.

gen_in_circle1([XC, YC], R, [X, Y]) :-
    gen_in_circle_00(R, A, B),
    X is A + XC,
    Y is B + YC.

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).

% gen_int_closed(L, M) : given list of ints L gen M : SET(M) is subset of SET(L)

gen_int_closed(L, M) :-
    distinct_elements(L, S),
    subset(S, M),
    is_integer_closed_with_rec(M, S).

subset([], []).
subset([_ | T], S) :- subset(T, S).
subset([H | T], [H | S]) :- subset(T, S).

distinct_elements([], []).
distinct_elements([H | T], R) :-
    distinct_elements(T, D),
    insert_distinct(H, D, R).
    
insert_distinct(E, D, D) :- member(E, D).
insert_distinct(E, D, [E | D]) :- not(member(E, D)).

is_integer_closed_with_rec(M, L) :- is_integer_closed_with_rec_helper(M, M, L).

is_integer_closed_with_rec_helper([], _, _).
is_integer_closed_with_rec_helper([H | T], M, L) :-
    is_integer_closed_with_rec_helper(T, M, L),
    is_element_closed(H, M, L).

is_element_closed(E, L, M) :-
    member(X, M),
    A is E + X,
    B is E - X,
    C is E * X,
    member(A, L),
    member(B, L),
    member(C, L).

is_integer_closed_with_not(M, L) :-
    not((member(A, M), not(is_element_closed(A, M, L)))).