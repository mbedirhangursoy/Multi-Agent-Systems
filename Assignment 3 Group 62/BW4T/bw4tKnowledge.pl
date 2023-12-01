% declarations of predicates used but not defined here.
:- dynamic
	in/1,		% percept predicate that informs where the robot is. 
	state/1,	% percept predicate to keep track of whether a robot is moving.
	visited/1,	% predicate to keep track of the rooms that have been visited.
	zone/5,		% percept predicate with information about all zones in BW4T.
	color/2, % provides information about the color of the blocks.
	holding/1, % provides information on the block this player is holding.
	sequence/1, % provides information about the color order in which blocks have to be dropped at the drop zone.
	sequenceIndex/1, % expresses the index of the currently needed color in the sequence
	atBlock/1,		% still need the fifth percept.
	block/3,
	completed_task/1,
	next_color_needed/1.

% A room is a place with exactly one neighbour; in other words, there is only one way to
% get to and from that place.
room(PlaceID) :- zone(_, PlaceID, _, _, Neighbours), length(Neighbours, 1).

% A room has not yet been visited if the robot has not yet been there.
not_yet_visited(PlaceID) :- room(PlaceID), not( visited(PlaceID) ).


completed_task(I):- sequence(List), length(List, Y), I is Y - 1, sequenceIndex(I).


next_color_needed(ColorID):- sequenceIndex(Index), sequence(ListColors), nth0(Index, ListColors, ColorID).