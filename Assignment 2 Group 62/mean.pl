sum_list([], 0).
sum_list([H|T], Sum):- sum_list(T, Rest), Sum is H + Rest.

mean(L,M):- sum_list(L, Sum), length(L, Length), (Length > 0 -> M is Sum / Length;  M is 0).
