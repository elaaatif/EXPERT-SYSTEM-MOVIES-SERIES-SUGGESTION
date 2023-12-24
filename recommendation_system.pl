% Check if X is an element of the list
elem(X, [X|_]).
elem(X, [_|Tail]) :- elem(X, Tail).

% Check whether lists have a common element
elems(X, [Y|_]) :- elem(Y, X).
elems(X, [_|Tail]) :- elems(X, Tail).

% Check if the main actor is male
is_male(usa, male).
is_male(uk, male).
is_male(spain, male).
% Add more countries and genders as needed.

% Check if the main actor is female
is_female(usa, female).
is_female(uk, female).
is_female(spain, female).
% Add more countries and genders as needed.

% Check if the main actor is diverse
is_diverse(usa, diverse).
is_diverse(uk, diverse).
is_diverse(spain, diverse).
% Add more countries and diversities as needed.

% Check if the main actor is from a specific origin
is_origin(Origin, Movie) :- movie(Movie, _, _, _, _, _, Origin, _).
is_origin(Origin, Serie) :- serie(Serie, _, _, _, _, Origin, _).

% Check if the main actor has a specific gender
has_gender(Gender, Movie) :- movie(Movie, _, _, _, _, _, _, Gender).
has_gender(Gender, Serie) :- serie(Serie, _, _, _, _, _, Gender).

list_movie(Director, Categories, Min, Max, Stream, Theme, Origin, Gender, L) :-
    list_movie(Director, Categories, Min, Max, Stream, Theme, Origin, Gender, [], L).

list_movie(Director, Categories, Min, Max, Stream, Theme, Origin, Gender, Acc, L) :-
    movie(Movie, Director, Category, Length, Streamings, Themes, MovieOrigin, MovieGender),
    elems(Theme, Themes),
    elem(Stream, Streamings),
    elem(Category, Categories),
    Length > Min-1,
    Length < Max+1,
    is_origin(Origin, Movie),
    has_gender(Gender, Movie),
    \+ elem(Movie, Acc), !,
    list_movie(Director, Categories, Min, Max, Stream, Theme, Origin, Gender, [Movie|Acc], L).

list_movie(_, _, _, _, _, _, _, _, L, L).

list_serie(Director, Categories, Min, Max, Stream, Theme, Origin, Gender, S) :-
    list_serie(Director, Categories, Min, Max, Stream, Theme, Origin, Gender, [], S).

list_serie(Director, Categories, Min, Max, Stream, Theme, Origin, Gender, Acc, S) :-
    serie(Serie, Director, Category, Episodes, Streamings, Themes, SerieOrigin, SerieGender),
    elems(Theme, Themes),
    elem(Stream, Streamings),
    elem(Category, Categories),
    Episodes > Min - 1,
    Episodes < Max + 1,
    is_origin(Origin, Serie),
    has_gender(Gender, Serie),
    \+ elem(Serie, Acc), !,
    list_serie(Director, Categories, Min, Max, Stream, Theme, Origin, Gender, [Serie | Acc], S).

list_serie(_, _, _, _, _, _, _, _, S, S).

% Other rules remain the same...

% Get a list of unique directors from movies
movie_directors(Directors) :-
    findall(Director, movie(_, Director, _, _, _, _, _, _), AllDirectors),
    list_to_set(AllDirectors, Directors).

% Print all movie directors
print_movie_directors :-
    write('List of Movie Directors:\n'),
    movie_directors(Directors),
    print_directors(Directors).

% Helper predicate to print directors
print_directors([]).
print_directors([Director | Rest]) :-
    format('~w\n', [Director]),
    print_directors(Rest).

% Get a list of unique directors from series
serie_directors(Directors) :-
    findall(Director, serie(_, Director, _, _, _, _), AllDirectors),
    list_to_set(AllDirectors, Directors).

% Print all series directors
print_serie_directors :-
    write('List of Series Directors:\n'),
    serie_directors(Directors),
    print_directors(Directors).

% -/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-

 % Suggest movie or series to a user
suggest_movie_or_serie(M) :-
    write('Choose one option:\n   1. Movie\n   2. Short Series\n'),
    read(Option),
    (Option = 1 ->
        suggest_movie(M)
    ; Option = 2 ->
        suggest_serie(M)
    ;
        write('Invalid option. Please choose either 1 or 2.\n'),
        suggest_movie_or_serie(M)
    ).

% Suggest short series to a user
suggest_serie(S) :-
    write('Type your age: '),
    read(Age),
    get_category(Age, Categories),
    write('Choose your mood: \n   happy   sad   angry   scared\n'),
    read(Mood),
    write('Choose a director from:\n'), print_serie_directors,
    read(Director),
    write('Choose your streaming platform: n   netflix   hbogo   prime   disney : \n'),
    read(Stream),
    write('Type minimum number of episodes: '),
    read(Min),
    write('Type maximum number of episodes: '),
    read(Max),
    write('Choose the origin: \n   usa   uk  .... \n'), % Add more options as needed
    read(Origin),
    write('Choose the main actor\'s gender: \n   male   female   diverse\n'),
    read(Gender),
    get_theme(Mood, Theme),
    list_serie(Director, Categories, Min, Max, Stream, Theme, Origin, Gender, S).

suggest_movie(M) :-
    write('Type your age: '),
    read(Age),
    get_category(Age, Categories),
    write('Choose your mood: \n   happy   sad   angry   scared\n'),
    read(Mood),
    write('Choose a director from:\n'), print_movie_directors,
    read(Director),
    write('Choose your streaming platform: \n   netflix   hbogo   prime   disney : \n'),
    read(Stream),
    write('Type minimum length of film in minutes: '),
    read(Min),
    write('Type maximum length of film in minutes: '),
    read(Max),
    write('Choose the origin: \n   usa   uk  .... \n'), % Add more options as needed
    read(Origin),
    write('Choose the main actor\'s gender: \n   male   female   diverse\n'),
    read(Gender),
    get_theme(Mood, Theme),
    list_movie(Director, Categories, Min, Max, Stream, Theme, Origin, Gender, M).

% ---------------------------------------------------------------------------------
% Get categories from user's age
get_category(Age, X) :- Age < 7, X = [g].
get_category(Age, X) :- Age > 6, Age < 13, X = [g, pg].
get_category(Age, X) :- Age > 12, Age < 16, X = [g, pg, pg13].
get_category(Age, X) :- Age > 15, Age < 18, X = [g, pg, pg13, r].
get_category(Age, X) :- Age > 17, X = [g, pg, pg13, r, nc17].

% Get themes from user's mood
get_theme(Mood, X) :-
    Mood = happy,
    X = [horror, comedy, action, sci-fi, animation, fantasy, war, musical, romance].

get_theme(Mood, X) :-
    Mood = sad,
    X = [comedy, family, mystery, animation, fantasy, musical].

get_theme(Mood, X) :-
    Mood = scared,
    X = [family, fantasy, musical, comedy].

get_theme(Mood, X) :-
    Mood = angry,
    X = [comedy, family, sci-fi, animation, drama, musical].
%--------------------------------------------------------
%DATABASE_OF_MOVIES
movie(blade_runner_2049, ridley_scott, r, 164, [netflix], [action, drama, mystery, sci-fi, thriller], usa, male).
movie(shrek, andrew_adamson, pg, 90, [netflix, prime], [animation, adventure, comedy, family, fantasy], usa, male).
movie(thor_ragnarok, taika_waititi, pg13, 130, [disney], [action, adventure, comedy, fantasy, sci-fi], usa, male).
movie(star_wars_episode_IV, george_lucas, pg, 121, [disney], [action, adventure, fantasy, sci-fi], usa, male).
movie(star_wars_episode_III, george_lucas, pg, 140, [disney], [action, adventure, fantasy, sci-fi], usa, male).
movie(man_of_steel, zack_snyder, pg13, 143, [netflix], [action, adventure, sci-fi], usa, male).
movie(justice_league, zack_snyder, pg13, 120, [hbogo], [action, adventure, fantasy, sci-fi], usa, male).
movie(indiana_jones_and_the_raiders_of_the_lost_ark, steven_spielberg, pg, 115, [prime], [action, adventure], usa, male).
movie(indiana_jones_and_the_last_crusade, steven_spielberg, pg13, 127, [netflix, prime], [action, adventure], usa, male).
movie(indiana_jones_and_the_temple_of_doom, steven_spielberg, pg, 118, [netflix, prime], [action, adventure], usa, male).
movie(what_we_do_in_the_shadows, taika_waititi, r, 86, [hbogo], [comedy, horror], usa, male).
movie(jojo_rabbit, taika_waititi, pg13, 108, [hbogo], [comedy, drama, war], usa, male).
movie(a_hard_days_night, richard_lester, g, 87, [prime, netflix], [comedy, musical], uk, male).
movie(help, richard_lester, g, 92, [prime, netflix], [adventure, comedy, musical], uk, male).
movie(magical_mystery_tour, richard_lester, g, 55, [prime, netflix], [comedy, fantasy, musical], uk, male).
movie(last_tango_in_paris, bernardo_bertolucci, nc17, 129, [hbogo], [drama, romance], france, male).
movie(interstellar, christopher_nolan, pg13, 169, [netflix, disney], [adventure, drama, sci-fi], usa, male).
movie(tenet, christopher_nolan, pg13, 150, [netflix, hbogo], [action, thriller, sci-fi], usa, male).
movie(dunkirk, christopher_nolan, pg13, 106, [prime], [action, thriller, drama, war], usa, male).
movie(inception, christopher_nolan, pg13, 148, [netflix], [action, adventure, sci-fi, thriller], usa, male).
movie(insomnia, christopher_nolan, r, 118, [prime], [drama, mystery, thriller], usa, male).
movie(prestige, christopher_nolan, pg13, 130, [hbogo], [drama, mystery, sci-fi], usa, male).
movie(notting_hill, roger_michell, pg13, 124, [netflix, prime], [drama, comedy, romance], uk, male).
movie(knives_out, rian_johnson, pg13, 130, [prime], [comedy, mystery, drama], usa, male).


movie(contratiempo, oriol_paulo, nc17, 130, [netflix], [crime], spain, male).
movie(the_godfather, francis_ford_coppola, r, 175, [hbogo], [drama, crime], usa, male).
movie(once_upon_a_time_in_hollywood, quentin_tarantino, r, 161, [netflix], [drama, comedy], usa, male).
movie(forrest_gump, robert_zemeckis, pg13, 142, [netflix], [drama, romance], usa, male).
movie(inglourious_basterds, quentin_tarantino, r, 153, [hbogo], [drama, action, war], usa, male).
movie(a_beautiful_mind, ron_howard, pg13, 135, [hbogo, prime], [drama], usa, male).
movie(the_incredibles, brad_bird, pg, 115, [hbogo, disney], [animation, action, family, comedy, sci-fi], usa, male).
movie(the_incredibles_2, brad_bird, pg, 118, [hbogo, disney], [animation, action, family, comedy, sci-fi], usa, male).
movie(titanic, james_cameron, pg13, 194, [hbogo], [drama, romance], usa, male).
movie(skyfall, sam_mendes, pg13, 143, [hbogo], [action], uk, male).
movie(the_theory_of_everything, james_marshal, pg13, 123, [netflix], [drama, romance], uk, male).
movie(joker, todd_phillips, r, 122, [netflix], [drama, crime], usa, male).
movie(finding_nemo, andrew_stanton, g, 100, [hbogo], [animation, comedy, family], usa, male).
movie(zodiac, david_fincher, r, 157, [hbogo, netflix], [crime, drama, mystery], usa, male).
movie(tangled, nathan_greno, pg, 100, [hbogo], [animation, comedy, family, romance, musical], usa, female).
movie(the_shawshank_redemption, frank_darabont, r, 142, [netflix], [drama], usa, male).
movie(the_lord_of_the_rings_the_fellowship_of_the_ring, peter_jackson, pg13, 130, [hbogo], [drama, mystery, sci-fi], usa, male).
movie(the_intern, nancy_meyers, pg13, 121, [netflix], [drama, comedy], usa, female).
movie(kung_fu_panda, mark_osborne, pg, 92, [netflix], [animation, action, comedy, family], usa, male).
movie(spirit_stallion_of_the_cimarron, kelly_asbury, g, 92, [netflix], [animation, drama], usa, male).
movie(spectre, sam_mendes, pg13, 148, [hbogo], [action], uk, male).
movie(the_dark_knight, christopher_nolan, pg13, 152, [hbogo], [action, drama, crime], usa, male).
movie(gran_torino, clint_eastwood, r, 116, [netflix], [drama], usa, male).
movie(saving_private_ryan, steven_spielberg, r, 169, [netflix], [drama, war], usa, male).
movie(the_notebook, nick_cassavetes, pg13, 123, [netflix], [drama, romance], usa, male).
movie(silver_linings_playbook, david_russell, r, 122, [netflix], [comedy, drama, romance], usa, male).
movie(se7en, david_fincher, r, 127, [netflix], [crime, mystery, drama], usa, male).

%-------------------------------------------
% DATABASE_OF_SERIES

serie(black_mirror, charlie_brooker, pg13, 22, [netflix], [drama, sci-fi, thriller], uk, diverse).
serie(fleabag, phoebe_waller_bridge, pg13, 12, [prime], [comedy, drama], uk, female).
serie(the_office, greg_daniels, pg, 9, [prime], [comedy], usa, diverse).
serie(stranger_things, matt_duffer, pg13, 25, [netflix], [drama, fantasy, horror, mystery, sci-fi, thriller], usa, diverse).
serie(the_mandalorian, jon_favreau, pg13, 16, [disney], [action, adventure, fantasy, sci-fi], usa, male).
serie(breaking_bad, vince_gilligan, r, 62, [netflix], [crime, drama, thriller], usa, male).
serie(friends, david_crane, pg, 10, [netflix], [comedy, romance], usa, diverse).
serie(the_queens_gambit, scott_frank, pg13, 7, [netflix], [drama], usa, female).
serie(the_crown, peter_morgan, pg13, 60, [netflix], [biography, drama, history], uk, diverse).
serie(the_witcher, lauren_schmidt_hissrich, r, 8, [netflix], [action, adventure, drama, fantasy, mystery], usa, male).
serie(the_big_bang_theory, chuck_lorre, pg13, 12, [netflix], [comedy, romance], usa, diverse).
serie(mindhunter, joe_penhall, r, 19, [netflix], [crime, drama, thriller], usa, diverse).
serie(brooklyn_nine_nine, michael_schur, pg13, 22, [netflix], [comedy, crime], usa, diverse).
serie(peaky_blinders, steven_knight, r, 30, [netflix], [crime, drama], uk, male).
serie(rick_and_morty, dan_harmon, pg13, 10, [netflix], [animation, adventure, comedy, sci-fi], usa, diverse).
serie(the_walking_dead, frank_darabont, r, 177, [netflix], [drama, horror, thriller], usa, diverse).
serie(narcos, chris_brancato, r, 30, [netflix], [biography, crime, drama, thriller], usa, diverse).
serie(ozark, bill_dubuque, ma, 36, [netflix], [crime, drama, thriller], usa, diverse).
serie(the_umbrella_academy, steve_blackman, r, 20, [netflix], [action, adventure, comedy, drama, fantasy, sci-fi], usa, diverse).
serie(the_twilight_zone, rod_serling, pg13, 10, [netflix], [drama, fantasy, horror, mystery, sci-fi, thriller], usa, diverse).
serie(band_of_brothers, erik_jendresen, r, 10, [hbogo], [action, drama, history, war], usa, diverse).
serie(chernobyl, craig_mazin, r, 5, [hbogo], [drama, history, thriller], usa, diverse).
serie(the_mandalorian, jon_favreau, pg13, 16, [disney], [action, adventure, fantasy, sci-fi], usa, male).
serie(westworld, jonathan_nolan, r, 28, [hbogo], [action, drama, mystery, sci-fi, western], usa, diverse).
