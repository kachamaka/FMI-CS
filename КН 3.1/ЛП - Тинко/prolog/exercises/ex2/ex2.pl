list([]).
list(X) :- X = [_ | T], list(T).

member(H, [H | _]).
member(X, [_ | T]) :- member(X, T).

% append(L1, L2, L3) : L3 = L1.L2

append([], L, L).
append([H | T], L, [H | R]) :- append(T, L, R).

% replace(X, Y, L, R) : R is L where X is replaced with Y
replace(_, _, [], []).
replace(X, Y, [X | T], [Y | R]) :- replace(X, Y, T, R).
replace(X, Y, [H | T], [H | R]) :- replace(X, Y, T, R), H \= X.

% first(X, L) : X is first element of L
first(X, [X | _]).

% last(X, L) : X is last element of L
last_rec(X, [X]).
last_rec(X, [_ | T]) :- last_rec(X, T).

last(X, L) :- append(_, [X], L).

% prefix(P, L) : P is prefix of L
prefix(P, L) :- append(P, _, L).

suffix(S, L) :- append(_, S, L). 

% sublist(S, L) : S is sublist of L
sublist(S, L) :- prefix(P, L), suffix(S, P).

% reverse(R, L) : R is the reverse of L
reverse([], []).
reverse(R , [H | T]) :- reverse(TR, T), append(TR, [H], R).

% palindrome(L) : L is palindrome
palindrome(L) :- reverse(L, L).

% remove_first(X, L, R) : R is L without first occurance of X
remove_first(X, [X | T], T).
remove_first(X, [H | T], [H | R]) :- X \= H, remove_first(X, T, R).


remove(_, [], []).
remove(X, [X | T], T).
remove(X, [H | T], [H | R]) :- X \= H, remove(X, T, R).

remove_all(_, [], []).
remove_all(X, [X | T], R) :- remove_all(X, T, R).
remove_all(X, [H | T], [H | R]) :- X \= H, remove_all(X, T, R).

% insert(X, L, R) : R is L in which in some position X is inserted
insert(X, L, R) :- append(P, S, L), append(P, [X | S], R).

% permutate(P, L) : P is permutation of L (P perm L)
permutate([], []).
permutate(P, [H | T]) :- permutate(Q, T), insert(H, Q, P).

% subsequence(S, L) : S is subsequence of L
subsequence([], []).
subsequence(S, [_ | T]) :- subsequence(S, T).
subsequence([H | S], [H | T]) :- subsequence(S, T).

% power_set(P, S) : P is power set of S (S has no repetitions)
power_set([[]], []).
% P({a} U S) = P(S) U (Union (M in P(S)) ({a} U M))
power_set(P, [A | S]) :- power_set(B, S), prepend_to_all(A, B, C), append(B, C, P).

prepend_to_all(_, [], []).
prepend_to_all(X, [L | LS], [[X | L] | RS]) :- prepend_to_all(X, LS, RS).


