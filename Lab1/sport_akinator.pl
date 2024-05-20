% consult("sport_akinator.pl").
main :- 
    retractall(asked(_,_)),
    sport(Sport), !, nl,
    write('Kind of sport is: '), write(Sport), write(.), nl.
main :- 
    nl, write('The kind of sport not found.'), nl.

kind(winter_sport) :-
    query('Is this a winter sport?').

kind(team_sport) :-
    query('Is this a team sport?').

kind(olympic_sport) :-
    query('Is this an Olympic sport?').

kind(extreme) :-
    query('Is this sport extreme?').

kind(water_sport) :-
    query('Is this a water sport?').

kind(ball) :-
    query('Is there a ball in this sport?').

kind(hands):-
    query('Is this sport played with hands?').

kind(ice):-
    query('Is this a sport on ice?').

sport(hockey):-
    kind(winter_sport),
    kind(team_sport),
    kind(olympic_sport).

sport(snowcross):-
    kind(winter_sport),
    kind(team_sport),
    kind(extreme).

sport(bandy):-
    kind(winter_sport),
    kind(team_sport),
    (enough_no(2) -> !, true).

sport(acrobatics_on_skis):-
    kind(winter_sport),
    kind(olympic_sport),
    kind(extreme).

sport(figure_skating):-
    kind(winter_sport),
    kind(olympic_sport),
    kind(ice).

sport(figure_skating):-
    kind(winter_sport),
    kind(olympic_sport).

sport(freeride):-
    kind(winter_sport),
    kind(extreme).

sport(dog_sledding_races):-
    kind(winter_sport).

sport(water_polo):-
    kind(team_sport),
    kind(olympic_sport),
    kind(water_sport),
    kind(ball).

sport(synchron_swimming):-
    kind(team_sport),
    kind(olympic_sport),
    kind(water_sport).

sport(football):-
    kind(team_sport),
    kind(olympic_sport),
    kind(ball).

sport(basketball):-
    kind(team_sport),
    kind(olympic_sport),
    kind(ball),
    kind(hands).

sport(badminton):-
    kind(team_sport),
    kind(olympic_sport).

sport(baseball):-
    kind(team_sport),
    (enough_no(2) -> !, true).

sport(sailing):-
    kind(olympic_sport),
    kind(extreme),
    (enough_yes(2) -> !, true).

sport(diving):-
    kind(olympic_sport),
    kind(water_sport).

sport(tennis):-
    kind(olympic_sport),
    kind(ball).

sport(athletics):-
    kind(olympic_sport).

sport(kayaking):-
    kind(extreme),
    kind(water_sport).

sport(rock_climbing):-
    kind(extreme).

sport(hydro_speed):-
    kind(water_sport).

sport(mini_golf):-
    kind(ball).

enough_no(Enough):-
    bagof(Prompt, asked(Prompt, n), List),
    length(List,Count),
    Count = Enough, !.

enough_yes(Enough):-
    bagof(Prompt, asked(Prompt, y), List),
    length(List,Count),
    Count = Enough, !.

query(Prompt) :-
    (
        asked(Prompt, Reply) -> true;   nl, write(Prompt), write(' (y/n)? '), 
        read(X), (X = y -> Reply = y ; Reply = n),
	    assert(asked(Prompt, Reply))
    ),
    Reply = y.