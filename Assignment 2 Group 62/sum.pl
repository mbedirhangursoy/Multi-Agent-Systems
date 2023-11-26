sum_list([], 0).
sum_list([H|T], Sum):- sum_list(T, Rest), Sum is H + Rest.


sum_initial(X, X, []).
sum_initial([X | W], Z, [X | Y]):- sum_initial(W, Z, Y).

sum_perm(X, Y, Z):- permutation(X, Result), sum_initial(Result, Y, Z).

sum(X, Y, Z):- sum_perm(X, Y, Z), sum_list(Y, Sum1), sum_list(Z, Sum2), Sum1 =:= Sum2.