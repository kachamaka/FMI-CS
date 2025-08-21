% in_circle_rat([P, Q], [[A, B], [C, D]]) : 
gen_in_circle_rat([P, Q], [[A, B], [C, D]]) :-
    gen_pair_rat([A, B], [C, D]),
    (A * D * Q)^2 + (C * B * Q)^2 =< (P * B * D)^2.

gen_pair_rat([P, B], [Q, D]) :-
    gen_4_tuple_nat(A, B, C, D),
    B > 0,
    D > 0,
    gcd(A, B, 1),
    gcd(C, D, 1),
    int(A, P),
    int(C, Q).

gen_KS(1, S, [S]).
gen_KS(K, S, [H | T]) :-
    K > 1,
    between(0, S, H),
    SH is S - H,
    K1 is K - 1,
    gen_KS(K1, SH, T).

between(A, B, A) :- A =< B.
between(A, B, K) :- A < B, A1 is A + 1, between(A1, B, K).

gen_4_tuple_nat(A, B, C, D) :- 
    nat(S),
    gen_KS(4, S, [A, B, C, D]).

nat(0).
nat(N) :- nat(K), N is K + 1.

int(0, 0).
int(N, N) :- N > 0.
int(N, K) :- N > 0, K is -N.

% gcd(A, 0, A) :- A \= 0.
% gcd(A, B, D) :- 
%     B \= 0,
%     R is A mod B,
%     gcd(B, R, D).

gcd(0, B, B) :- B =\= 0.
gcd(A, B, D) :- 
    A =\= 0,
    R is B mod A,
    gcd(R, A, D).


% is_graph([V, E]) : if [V, E] is graph, not oriented
% (1, 2) edge, [1, 2] member of E and [2, 1] not member of E
% V is sorted

is_graph([V, E]) :-
    not((append(_, [A, B | _], V), A >= B)),
    not((member(X, V), member(Y, V), member([X, Y], E), not((X < Y, not(member([Y, X], E)))))).

append([], X, X).
append([H | T], L, [H | R]) :- append(T, L, R).

is_hamiltonian([V, E]) :-
    permutate(V, [Start | Rest]),
    check_path([V, E], [Start | Rest]),
    last([Start | Rest], End),
    edge([V, E], [End, Start]).

permutate([], []).
permutate([H | T], P) :- permutate(T, P1), insert(H, P1, P).

insert(X, L, R) :- append(P, S, L), append(P, [X | S], R).

last(L, X) :- append(_, [X], L).

edge([_, E], [X, Y]) :- X < Y, member([X, Y], E).
edge([_, E], [X, Y]) :- X > Y, member([Y, X], E).

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).

check_path([_, _], [_]).
check_path([V, E], [X, Y | Rest]) :-
    check_path([V, E], [Y | Rest]),
    edge([V, E], [X, Y]).

% gen_nat_graph(G) : gen all graphs G
gen_nat_graph([V, E]) :-
    nat(N), N > 0,
    range(1, N, V),
    gen_all_edges(V, All),
    subset(E, All).

% range(A, B, L) : L is list of [A, A + 1, ..., B]
range(A, B, []) :- A > B.
range(A, B, [A | R]) :- A =< B, A1 is A + 1, range(A1, B, R).

subset([], []).
subset(S, [_ | T]) :- subset(S, T).
subset([H | S], [H | T]) :- subset(S, T).

gen_all_edges([], []).
gen_all_edges([V | VS], All) :-
    gen_all_edges_for_vertex([V | VS], LV),
    gen_all_edges(VS, R),
    append(LV, R, All).

gen_all_edges_for_vertex([_], []).
gen_all_edges_for_vertex([H | T ], L) :-
    T \= [],
    insert_first_to_all(H, T, L).

insert_first_to_all(_, [], []).
insert_first_to_all(X, [H | T], [ [X, H] | R ]) :- insert_first_to_all(X, T, R).

gen_nat_ham_graph(G) :-
    gen_nat_graph(G),
    is_hamiltonian(G).