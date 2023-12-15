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
	completed_task/0,
	next_color_needed/1,
	found_all_blocks_still_needed/0.
	target/2.
	next_color_i_need/1.

% A room is a place with exactly one neighbour; in other words, there is only one way to
% get to and from that place.
room(PlaceID) :- zone(_, PlaceID, _, _, Neighbours), length(Neighbours, 1).

% A room has not yet been visited if the robot has not yet been there.
not_yet_visited(PlaceID) :- room(PlaceID), not( visited(PlaceID) ).
 
 % If the sequence index equals to the length of the sequence list, then we know that we have completed our job.
completed_task:- sequence(List), length(List, Y), sequenceIndex(Y).

% if the list of blocks in the sequence is a subset of all the blocks that we observe, then we know that we found all the blocks that we needed.
found_all_blocks_still_needed:- sequence(List), findall(ColorID, block(_,ColorID,_), List2), subset(List, List2).

% it uses that sequence Index to find the next color needed from the sequence list.
next_color_needed(ColorID):- sequenceIndex(Index), sequence(ListColors), nth0(Index, ListColors, ColorID).

% find the next color the robot itself needs.
next_color_i_need(ColorID):- target(self, Index), sequence(ListColors), nth0(Index, ListColors, ColorID).


find_next_index_target(Index):- sequenceIndex(Index); sequenceIndex(IndexOld), IndexOld < 5, Index is IndexOld + 1.