% is_list_transversal(L, T) : L is list of lists and T is list where T is transversal for L
is_list_transversal([], _).
is_list_transversal([X | XS], Transversal) :-
    member(A, X),
    member(A, Transversal),
    !, % cut, stop when reach true.
    is_list_transversal(XS, Transversal).

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).

is_list_transversal_with_not(L, T) :-
    not((member(X, L), not((member(A, T), member(A, X))))).

% gen_list_transversal(L, T) : gen T: T is list transversal for L (list of lists)

% gen_list_transversal([], []).
% gen_list_transversal([X | XS], [H | R]) :-
%     member(H, X),
%     gen_list_transversal(XS, R).
% each transversal has fixed length - problem

gen_list_transversal(L, T) :-
    union_of_elements(U, L),
    subsequence(T, U),
    is_list_transversal(L, T).  

% join([], []).
% join(U, [L | LS]) :- join(R, LS), append(L, R, U).
    
append([], X, X).
append([H | T], L, [H | R]) :- append(T, L, R).

union_of_elements([], []).
union_of_elements(U, [L | LS]) :- 
    union_of_elements(R, LS), 
    set_minus(L, R, Temp),
    append(Temp, R, U).

set_minus([], _, []).
set_minus([X | S], M, R) :-
    set_minus(S, M, R),
    member(X, M).
set_minus([X | S], M, [X | R]) :-
    set_minus(S, M, R),
    not(member(X, M)).

% set_minus([], _, []).
% set_minus([X | S], M, U) :-
%     set_minus(S, M, R),
%     conditional_add(X, R, M, U).

% conditional_add(X, A, B, A) :- member(X, B).
% conditional_add(X, A, B, [X | A]) :- not(member(X, B)).

subsequence([], []).
subsequence(S, [_ | T]) :- subsequence(S, T).
subsequence([H | S], [H | T]) :- subsequence(S, T).

gen_list_min_transversal(L, M) :-
    gen_list_transversal(L, M),
    not((member(X, M),
    append(P, [X | S], M),
    append(P, S, U),
    is_list_transversal(L, U))).

list_length([], 0).
list_length([_ | T], N) :- list_length(T, K), N is K + 1.

gen_length_of_min_list_transversal(L, K) :-
    gen_list_min_transversal(L, M),
    list_length(M, K).

gen_minimal_length_of_transversal(L, K) :-
    list_length(L, N),
    between(1, N, K),
    gen_list_min_transversal(L, M),
    list_length(M, K),
    K1 is K - 1,
    not((gen_list_min_transversal(L, T), list_length(T, K1))).

between(A, B, A) :- A =< B.
between(A, B, K) :- A < B, A1 is A + 1, between(A1, B, K).


% gen_K_subsequence(_, 0, []).
% gen_K_subsequence(L, K, [H | T]) :-
%     K > 0,
%     member(H, L),
%     K1 is K - 1,
%     gen_K_subsequence(L, K1, T).

gen_K_subsequence(_, 0, []).
gen_K_subsequence([_ | T], K, S) :- K > 0, gen_K_subsequence(T, K, S).
gen_K_subsequence([H | T], K, [H | S]) :- K > 0, K1 is K - 1, gen_K_subsequence(T, K1, S).