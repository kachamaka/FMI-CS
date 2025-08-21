% nat(X) :- X = zero.
% nat(X) :- X = s(Y), nat(Y).
nat(zero).
nat(s(X)) :- nat(X).

add(zero, Y, Y) :- nat(Y).
add(s(X), Y, s(Z)) :- add(X, Y, Z).
% add(s(X), Y, Z) :- add(X, Y, T), Z = s(T).


% word(X) - X is word over {a, b, c}, epsilon, f(a, epsilon), f(a, f(b, epsilon))...
% word(epsilon).
% word(X) :- X = starts_with(L, W), L = a, word(W).
% word(X) :- X = starts_with(L, W), L = b, word(W).
% word(X) :- X = starts_with(L, W), L = c, word(W).

word(epsilon).
% starts_with(L, W) -> L.W
word(starts_with(L, W)) :- word(W), letter(L).
letter(a).
letter(b).
letter(c).
letter(d).

% member(X, W) -> X is letter of W
% member(X, W) :- word(W), W = starts_with(X, R).
member(X, starts_with(X, R)) :- letter(X), word(R).
% member(X, W) :- word(W), W = starts_with(L, R), member(X, R).
member(X, starts_with(L, W)) :- member(X, W).