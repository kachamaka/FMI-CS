% graph_color([V, E], K, C) : K is number of colors
graph_color_helper([], _, []).
graph_color_helper([V | VS], K, [[V, M] | T]) :-
    graph_color_helper(VS, K, T),
    S is K - 1,
    between(0, S, M).

gen_K_admisible_coloring([V, E], K, C) :-
    graph_color_helper(V, K, C),
    not((
        member([U, W], E),
        member([U, M], C),
        member([W, S], C),
        M =:= S         
    )),
    T is K - 1,
    not((
        between(0, T, M),
        not(member([_, M], C))    
    )).

% this uses knowledge about how between generates numbers from A to B
% chrom_number(G, K) : K is the chromatic number of G
% chrom_number([V, E], K) :-
%     list_length(V, N),
%     between(1, N, K),
%     gen_K_admisible_coloring([V, E], K, _),
%     !.

chrom_number([V, E], K) :-
    list_length(V, N),
    between(1, N, K),
    gen_K_admisible_coloring([V, E], K, _),
    K1 is K - 1,
    not(gen_K_admisible_coloring([V, E], K1, _)),
    !.

list_length([], 0).
list_length([_ | T], N) :- list_length(T, M), N is M + 1.

% path([V, E], S, F, P) : P is path in graph from S to F
path([V, E], S, F, P) :-
    subset(M, V),
    member(S, M),
    member(F, M),
    permutate(M, P),
    is_path([V, E], P).

edge([U, W], E) :- member([U, W], E).
edge([U, W], E) :- member([W, U], E).

subset([], []).
subset(S, [_ | T]) :- subset(S, T).
subset([H | S], [H | T]) :- subset(S, T).

permutate([], []).
permutate([H | T], P) :- permutate(T, Q), insert(H, Q, P).

insert(X, L, R) :- append(P, S, L), append(P, [X | S], R).

is_path([_, _], [_]).
is_path([V, E], [U, W | P]) :-
    edge([U, W], E),
    is_path([V, E], [W | P]).


path_imp([_, E], S, F, P) :- path_imp_track_visited(E, F, [S], P).

path_imp_track_visited(_, F, [F | Visited], P) :- reverse([F | Visited], P).
path_imp_track_visited(E, F, [T | Rest], P) :- 
    T \= F,
    edge([T, U], E),
    not(member(U, Rest)),
    path_imp_track_visited(E, F, [U, T | Rest], P).

path([V, E], P) :-
    member(S, V),
    member(F, V),
    S \= F,
    path_imp([V, E], S, F, P).

is_connected([V, E]) :-
    not((
        member(S, V),
        member(F, V),
        S \= F,
        not(path_imp([V, E], S, F, _))
    )).

is_acyclic([V, E]) :-
    not((
        member(S, V), 
        member(F, V), 
        S \= F,
        path_imp([V, E], S, F, P1),
        path_imp([V, E], S, F, P2),
        P1 \= P2
    )).

is_tree(G) :-
    is_connected(G),
    is_acyclic(G).

is_bin_tree([V, E]) :-
    is_tree([V, E]),
    member(R, V),
    is_bin_tree_with_root([V, E], R),
    !.

% is_bin_tree_with_root([V, E], R) :- neighbours(R, [C, E], Vertices).
