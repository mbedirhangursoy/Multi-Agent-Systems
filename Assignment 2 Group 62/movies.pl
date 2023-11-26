movie("The Imitation Game",[actor("Knightely","Keira"),
actor("Cumberbatch","Benedict")],[genre("drama")],114,13,8).
movie("The Godfather",[actor("Brando","Marlon")],[genre("drama"),genre("crime")],170,18,9).
movie("A Bad Movie",[actor("Eastwood","Clint")],[genre("action")],100,16,2).
movie("Z Good Movie",[actor("Thurman","Uma")],[genre("thriller")],90,16,10).


listMovies(Result):- findall(L, movie(L, _,_,_,_,_),Result).

listMoviesByName(F):- listMovies(L), sort(L, F).



listMoviesByGenre(G, Result):- findall(L, (movie(L, _, Gs,_,_,_), member(G, Gs)), Result).


:- use_module(library(pairs)).
db([
movie("The Imitation Game",[actor("Knightely","Keira"),actor("Cumberbatch","Benedict")],
[genre("drama")],114,13,8),
movie("The Godfather",[actor("Brando","Marlon")],[genre("drama"),genre("crime")],170,18,9),
movie("A Bad Movie",[actor("Eastwood","Clint")],[genre("action")],100,16,2),
movie("Z Good Movie",[actor("Thurman","Uma")],[genre("thriller")],90,16,10)
]).


extract_negated_rank_and_title(movie(Title, _, _, _, _, Rank), NegRank-Title) :-
    NegRank is -Rank.

sort_movies_by_rank_desc(DB, SortedTitles) :-
    maplist(extract_negated_rank_and_title, DB, Pairs),
    keysort(Pairs, SortedPairs),
    pairs_values(SortedPairs, SortedTitles).

listMoviesByRank(DB, SortedTitles) :-
    sort_movies_by_rank_desc(DB, SortedTitles).

% Predicate to check if a movie is of a specified genre
is_of_genre(genre(GenreName), movie(_, _, Genres, _, _, _)) :-
    member(genre(GenreName), Genres).

% Predicate to count movies of a specific genre
numberMovies(MoviesList, Genre, Count) :-
    include(is_of_genre(Genre), MoviesList, FilteredMovies),
    length(FilteredMovies, Count).




