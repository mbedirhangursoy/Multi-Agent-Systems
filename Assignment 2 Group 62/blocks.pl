on(a,b).
on(b,c).
on(c,d).
on(d,e).
on(e,table).

above(X, Y) :- on(X, Y).
above(X, Y) :- on(X, Z), above(Z, Y).


above_acc(X, Y, A, A):- on(X, Y).
above_acc(X, Y, A, L):- Anew is A+1, on(X, Z), above_acc(Z, Y, Anew, L).

atLeastThree(X):- above_acc(X, Y, 1, L), L >= 3.

exactlyThree(X):- above_acc(X, Y, 1, L), L =:= 3.

tower([X]) :- on(X,table).
tower([X,Y|T]) :- on(X,Y), tower([Y|T]).


acc_tower([X], A, A):- on(X, table).
acc_tower([X,Y|T], A, L):- Anew is A+1, on(X, Y), acc_tower([Y|T], Anew, L).

exactlyThreeTower(X):- acc_tower([X,Y|T], 0, L), L =:= 3.

