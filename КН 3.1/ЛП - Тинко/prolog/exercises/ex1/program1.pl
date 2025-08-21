%1
after(dis2, dis1).
after(va, la).
after(oop, up).

% usex(X, Y) :- after(X, Y).
%2.1
after(dupril, dis2).
after(dupril, la).
after(eai, ds).
after(sdp, oop).
after(sdp, ds).

%2.2
after(chm, dis1).
after(chm, la).
after(daa, ds).
after(daa, sdp).
after(lp, ds).
after(lp, eai).


% :- is like <-
% uses1(X, Y) :- after(X, Y).
% uses2(X, Y) :- after(Z, Y), after(X, Z). % and
% uses3(X, Y) :- after(Z, Y), uses2(X, Z). 

% or
uses(X, Y) :- after(X, Y).
uses(X, Y) :- after(Z, Y), uses(X, Z).