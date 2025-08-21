% Нека G е неориентиран граф. Множеството от върховете на G е
% представено със списък V от върховете, всякоо ребро 'е' е представено
% с двуелементен списък на краищата му, а множеството от ребрата на G е
% представено със списък E от ребрата. Да се дефинира на пролог педикат
% con(V,E), който разпознава дали представеният с V и E граф е свързан.
%
% crit(V,E,X), който по дадени V и E на свързан граф генерира в X списък
% на всички върхове, чието отстраняване води до граф, който не е
% свързан.

% та s member беше нещо от родана : да не съществуват А и Б от В за които
% да няма ребро А, Б или Б, А което да не е член на Е

% V  spisak ot varhovete my,
% E spisak ot dvu elementeni spisaci
% con(V, E). -> dali e svarzan graf
%

%V -> [a, b, c]
%E ->  [[a,b], [b,c]]

%path(A, B):- edge(A,B).e
%path(A, B):- edge(A,C), path(C,B).
%
%
%

%fib(1, 1).
%fib(B, C) :- fib(A, B), C is A + B.
%fib(X) :- fib(X, _).



numelem(X, [X|_], 1).
numelem([H|X], [H|L], K) :- K > 1, K1 is K - 1, numelem(X, L, K1).

listCmp([H|T],[H|T]).
listCmp(L1, L2) :- revM(L1, X), listCmp(X, L2).

pathTwoEdges(V1, V2, E) :- memberM(A, E), listCmp([V1,V2], A).
path(Vh, [H|_], E) :- pathTwoEdges(Vh, H, E).
con([_], _).
con([Vh|Vt], E) :- path(Vh, Vt, E), con(Vt, E).




%remove в дълбочина

appendM([], B, B).
appendM([X|Xt], Y, [X|Z]) :- appendM(Xt, Y, Z).

memberM(H, [H|_]).
memberM(E, [_|T]) :- memberM(E, T).

issetM([]).
issetM([X|Xt]) :- not(memberM(X, Xt)), issetM(Xt).

issetM2(L):-not((appendM(A,B,L), memberM(E,A), memberM(E,B))).

remMH(H, [H|T], T).
remMH(X, [Y|Yt], [Y|Zt]) :- remMH(X, Yt, Zt).

revMH([], L2, L2).
revMH([L1|T1],L2, Acc) :- revMH(T1, L2, [L1|Acc]).

revM(L1, L2) :- revMH(L1, L2, []).
warning(H).
%
%appendM([], Y, Y).
%appendM([X|Xt], Y, [X|Z]) :-  appendM(Xt, Y, Z).

%lastm(X, [X]).
%lastm(X, [_|T]) :- lastm(X, T).

%subsetM([], Y).
%subsetM([H|T], Y) :- mem(H, Y), subsetM(T, Y).


%mem(H, [H|_]).
%mem(H, [X|T]) :- mem(H, T).

% a b c

%issetHelper([],[]).

nat(0).
nat(X):- nat(Y), X is Y + 1.

nat(X,Y):-nat(N),bet(X,0,N),Y is N-X.
nat1(X,Y):-nat1(Y,Z),Z is X+Y.

arit(An, 1, D):- An is 1 + D.
arit(X, A, D) :- arit(Z, A, D), X is Z + D.

%geom (A2, A1, Q, N)
%N is current member

 %nat2(X,Y).
%nat2(X,Y).
%
%between(A,B,C).
between(A,A,B):- A =< B.
between(A,B,C):- B < C, B1 is B + 1, between(A,B1,C).

%nat2(X,Y):- nat(N), beween(X,
%

nat2(X,Y):- nat(N), between(X, 2, N), Y is N-X.

%gen(X,Y):- nat2(X,Y), X  Y.


bet(A,A,B):- A =<B.
bet(A,B,C):- B < C, B1 is B+1, bet(A,B1,C).

betP(A,A,B,_):- A =< B.
betP(A,B,C, Q):- B < C, B1 is B*Q, betP(A, B1, C, Q).

progg(X):- nat(I), bet(Q,2,I) ,betP(X, 1, I, Q).



%
%septemvri 2013 zad 2
%red(1,X):- X is 3*1  + 2.
red(1,5).
red(X,Y):- red(Z,X), Y is 3*X + 2.

red(X):- red(X,_).


p(N):- ph(N,N).

ph(N,N):- between(X,1,N), Y is N - X, check_sum(X,Y).

%check_sum(X, Y):- red(X), red(Y).
check_sum(X, Y):- X == 2, Y == 5.

intt(N):-nat(L), (N = L; N is - L).

%graphs------------------
connected(G) :- not((vertex(X,G), vertex(Y,G),
		     not(pathG(X,Y,G)))).
%orientiran
%vertex(V,G):-member(V,A),member(A,G).

%neorientiran
vertex(V,G) :- member([V|_],G).

pathG(X,X,G).
pathG(X,Y,G):- successor(X,Z,G),remove_vertex(X,G,G1),
	      pathG(Z,Y,G1).

successor(X,Z,G):-member([X,Z],G).

remove_vertex(X,[H|T],T1):- member(X,H), remove_vertex(X,T,T1).
remove_vertex(X,[H|T],[H,T1]):- not(member(X,H)), remove_vertex(X,T,T1).
remove_vertex(_,[],[]).


fib(1, 1).
fib(X,Y) :- fib(Z, X), Y is Z + X, Y<10.

fib(X):-fib(X,_).

%18.02.2014 izpit zadacha 2
%union(A,B,C).
union([],L,L).
union([H|T],B,C):-member(H,B),union(T,B,C).
union([H|T],B,[H|C]):-not(member(H,B)),union(T,B,C).

% neshto se bqh obarkal nz ko sam pisal
% inter(A,B,C):- intersect(A, B, AB), intersect(B, A, BA),append(AB, BA,
% C).
% tyi e Ok:
intersect([],_,[]).
intersect([H|A], B, X):- not(member(H, B)), intersect(A,B,X).
intersect([H|A], B, [H|X]):- member(H, B), intersect(A,B,X).


%takeN(L,NL,N).
takeN(_,[],0).
takeN([H|T],[H|B],N):- N1 is N - 1,takeN(T,B,N1).

takeAll([],L,L,_).
takeAll([X],L2,L3,N):-append(L2,[[X]], Z), takeAll([],Z,L3,N).
takeAll(L1,L2,L3,N):- takeN(L1,Q,N), append(Q,Pl,L1),
	            append(L2,[Q], Z), takeAll(Pl, Z, L3,N).
appendd([],L,L).
appendd([H|T],L,[H|T2]):- appendM(T,L,T2).

%perm([],[]).
%perm(L,[H|T]):-appendd(V,[H|U], L), appendd(V,U,W), perm(W,T).

first([H|_],H).
second([_,Y|_],Y).

q(N, L):- not(qH(N,L)).

qH(N,L):-perm(L,L1), takeAll(L1,[],L2,N),
	first(L2,F),
	second(L2,S),
	union(F, S, Q),
	not(multiunion(Q,L2)).

multiunion(_,[]).
multiunion(Q,[H|T]):- checkForAll(H, T, Q),multiunion(Q,T).

checkForAll(_,[],_).
checkForAll(E, [H|L], Q):- union(E,H,Z), eqL(Z,Q),
	                checkForAll(E,L,Q).

eqL(L1, L2):- equalLen(L1,L2),checkE(L1, L2), checkE(L2, L1).
checkE([],_).
checkE([H|T], T2):- member(H,T2), checkE(T,T2).



% zad spisachnata redica na fib
%
fq(A,B,C):- append(A,B,AB), C == AB.
fq(A,B,C):- append(A,B,AB), not(C == AB),checkLen(A,B,C),
	   fq(B,AB,C).

lengthm([],0).
lengthm([H|L],X):-lengthm(L,X1), X is X1 + 1.

checkLen(A,B,C):- lengthm(A,X), lengthm(B,Y), lengthm(C,Z),
	           X + Y < Z.

equalLen(A,B):- lengthm(A,X), lengthm(B,Y),
	           X == Y.

redd(X):-red(Y,Z), X < Y.


% kontrolno 6.IV.2013 г. ot fmi wiki
%
pK(L) :- pred(L).
%pred([]).
pred([]).
pred([H|T]):- deeper_pred(H,T), pred(T).

%
%deeper_pred(H,[Y|T]) :- intersect(H,Y,Z), deeper_member(Z,T).
deeper_pred(_,[]).
deeper_pred(H,[Y|T]) :- intersect(H,Y,Z), deeper_member(Z,T),
	                deeper_pred(H, T).
%
%deeper_member(Z,[H|T]):- compare(Z,H).
deeper_member(_,[]).
deeper_member(Z,[H|T]):- compare(Z,H), deeper_member(Z,T).

%H e spisak i T e spisak
is_empty([]).

compare(H, Y):- intersect(H,Y,Z), is_empty(Z).


% generator na podmnojestva
%

dasub0(List, List).
dasub0(List, Rest):-dasub1(List, Rest).
dasub1([_|Tail], Rest):-dasub0(Tail, Rest).
dasub1([Head|Tail], [Head|Rest]):-dasub1(Tail, Rest).

%int(N):-nat(L), (N = L; N is - L).

chetno(X):- 0 is X mod 2.

betChet(A,A,B) :- A =< B.
betChet(A,B,C):- B < C, B1 is B+1,betChet(A,B1,C).

%pp(N):- nat(X),  bet(Z,1,X), get0N(R, Z), append(R,[],N).
pp(N):- nat(X), get0N(R, X), append(R,[],N).

get0N([0],0).
get0N(L,N):- N >= 0, Np is N - 1, get0N(Lp,Np), append(Lp,[N],L).


appendC(Lp, N, L):- chetno(N), append(Lp, N, L).
appendC(Lp, N, L):- not(chetno(N)), append(Lp, [], L).

ppg(N):- nat(X), X > 3, bet(Q,2,X), get0NQ(R, X, Q, 1), append(R,[],N).

get0NQ([0],0, Q, R).
get0NQ(L,N, Q, R):- N >= 0, Np is N - 1, R1 is R *Q, get0NQ(Lp,Np,Q,R1),
	append(Lp,[R],L).


%appendC(Lp, N, L):- chetno(N), append(Lp, N, L).
%appendC(Lp, N, L):- not(chetno(N)), append(Lp, [], L).
%
%generaira s preuve. slvaniq na spisaci A i B v C

q(A,B,C):- length(A,Al), length(B,Bl), qu(A,B,C,Al,Bl).

qu(A,B,C,Al,Bl):- perm(A,AA), perm(B,BB), between(K,1,Al),between(K2,1,Bl),
	     takeN(AA,AAA, K), takeN(BB,BBB, K2), sort(AAA,AAAA), sort(BBB,BBBB),
	     union(AAAA,BBBB, C).


insertt(A,B,[A|B]).
insertt(A,[H|B],[H|C]):- insertt(A,B,C).

sorted([]).
sorted([_]).
sorted([H,Y|T]) :- H =< Y, sorted([Y|T]).
perm([],[]).
perm([A|B],Z):- perm(B,C), insertt(A,C,Z).
sortt(A,B):- perm(A,B), sorted(B).



