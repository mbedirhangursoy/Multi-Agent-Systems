bike(wn_entrance,mb_entrance,1).
bike(botanic_garden,wn_entrance,4).
walk(wn_entrance,wn_k137,2).
walk(mb_entrance,mb_6th_floor,5).

route_by_bike(A, B):- bike(A, B, _).
route_by_bike(A, B):- bike(A, C, _), route_by_bike(C, B).

routeT(A, B):- bike(A, B, _); walk(A, B, _).
routeT(A, B):- bike(A, C, _), routeT(C, B); walk(A, C, _), routeT(C, B).

routeAcc(A, B, T, R):- bike(A, B, G), R is G+T; walk(A, B, G), R is G+T.
routeAcc(A, B, T, L):- bike(A, C, M), N is M + T, routeAcc(C, B, N, L); walk(A, C, M), N is M + T, routeAcc(C, B, N, L).

route(A, B, L):- routeAcc(A, B, 0, L).