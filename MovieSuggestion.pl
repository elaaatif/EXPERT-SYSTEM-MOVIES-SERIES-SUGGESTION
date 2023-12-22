%Check if X is element of List
elem(X,[X|_]).
elem(X,[_|Tail]) :- elem(X,Tail).

%Check whether lists have a common element
elems(X,[Y|_]) :- elem(Y,X).
elems(X,[_|Tail]) :- elems(X,Tail).

list_movie(Director,Categories,Min,Max,Stream,Theme, L) :-
    list_movie(Director,Categories,Min,Max,Stream,Theme, [], L).

list_movie(Director,Categories,Min,Max,Stream,Theme, Acc, L) :-
    movie(Movie,Director,Category,Length,Streamings,Themes),
    elems(Theme,Themes),
    elem(Stream,Streamings),
    elem(Category,Categories),
    Length > Min-1,
    Length < Max+1,
    \+ elem(Movie, Acc), !,
    list_movie(Director,Categories,Min,Max,Stream,Theme,[Movie|Acc], L).

list_movie(_,_,_,_,_,_, L, L).

% Generate a list of suggested series
list_serie(Director, Categories, Min, Max, Stream, Theme, S) :-
    list_serie(Director, Categories, Min, Max, Stream, Theme, [], S).

list_serie(Director, Categories, Min, Max, Stream, Theme, Acc, S) :-
    serie(Serie, Director, Category, Length, Streamings, Themes),
    elems(Theme, Themes),
    elem(Stream, Streamings),
    elem(Category, Categories),
    Length > Min - 1,
    Length < Max + 1,
    \+ elem(Serie, Acc), !,
    list_serie(Director, Categories, Min, Max, Stream, Theme, [Serie | Acc], S).

list_serie(_, _, _, _, _, _, S, S).

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
    write('Choose a director from:\n    (List of directors)\n'),
    read(Director),
    write('Choose your streaming platform: \n   netflix   hbogo   prime   disney:\n'),
    read(Stream),
    write('Type minimum length of series in minutes: '),
    read(Min),
    write('Type maximum length of series in minutes: '),
    read(Max),
    get_theme(Mood, Theme),
    list_serie(Director, Categories, Min, Max, Stream, Theme, S).
suggest_movie(M) :-
    write('Type your age: '),
    read(Age),
    get_category(Age, Categories),
    write('Choose your mood: \n   happy   sad   angry   scared\n'),
    read(Mood),
    write('Choose a director from:\n    (List of directors)\n'),
    read(Director),
    write('Choose your streaming platform: \n   netflix   hbogo   prime   disney:\n'),
    read(Stream),
    write('Type minimum length of film in minutes: '),
    read(Min),
    write('Type maximum length of film in minutes: '),
    read(Max),
    get_theme(Mood, Theme),
    list_movie(Director, Categories, Min, Max, Stream, Theme, M).
%Get categories from user's age
get_category(Age,X) :- Age < 7, X = [g].
get_category(Age,X) :- Age > 6, Age < 13, X = [g,pg].
get_category(Age,X) :- Age > 12, Age < 16, X = [g,pg,pg13].
get_category(Age,X) :- Age > 15, Age < 18, X = [g,pg,pg13,r].
get_category(Age,X) :- Age > 17, X = [g,pg,pg13,r,nc17].

%Get themes from user's mood
get_theme(Mood,X) :-
    Mood = happy,
    X = [horror,comedy,action,sci-fi,animation,fantasy,war,musical,romance].

get_theme(Mood,X) :-
    Mood = sad,
    X = [comedy,family,mystery,animation,fantasy,musical].

get_theme(Mood,X) :-
    Mood = scared,
    X = [family,fantasy,musical,comedy].

get_theme(Mood,X) :-
    Mood = angry,
    X = [comedy,family,sci-fi,animation,drama,musical].

%DATABASE_OF_MOVIES
movie(blade_runner_2049,ridley_scott,r,164,[netflix],[action,drama,mystery,sci-fi,thriller]).
movie(shrek,andrew_adamson,pg,90,[netflix,prime],[animation,adventure,comedy,family,fantasy]).
movie(thor_ragnarok,taika_waititi,pg13,130,[disney],[action,adventure,comedy,fantasy,sci-fi]).
movie(star_wars_episode_IV,george_lucas,pg,121,[disney],[action,adventure,fantasy,sci-fi]).
movie(star_wars_episode_III,george_lucas,pg,140,[disney],[action,adventure,fantasy,sci-fi]).
movie(man_of_steel,zack_snyder,pg13,143,[netflix],[action,adventure,sci-fi]).
movie(justice_league,zack_snyder,pg13,120,[hbogo],[action,adventure,fantasy,sci-fi]).
movie(indiana_jones_and_the_raiders_of_the_lost_ark,steven_spielberg,pg,115,[prime],[action,adventure]).
movie(indiana_jones_and_the_last_crusade,steven_spielberg,pg13,127,[netflix,prime],[action,adventure]).
movie(indiana_jones_and_the_temple_of_doom,steven_spielberg,pg,118,[netflix,prime],[action,adventure]).
movie(what_we_do_in_the_shadows,taika_waititi,r,86,[hbogo],[comedy,horror]).
movie(jojo_rabbit,taika_waititi,pg13,108,[hbogo],[comedy,drama,war]).
movie(a_hard_days_night,richard_lester,g,87,[prime,netflix],[comedy,musical]).
movie(help,richard_lester,g,92,[prime,netflix],[adventure,comedy,musical]).
movie(magical_mystery_tour,richard_lester,g,55,[prime,netflix],[comedy,fantasy,musical]).
movie(last_tango_in_paris,bernardo_bertolucci,nc17,129,[hbogo],[drama,romance]).
movie(interstellar,christopher_nolan,pg13,169,[netflix,disney],[adventure,drama,sci-fi]).
movie(tenet,christopher_nolan,pg13,150,[netflix,hbogo],[action,thriller,sci-fi]).
movie(dunkirk,christopher_nolan,pg13,106,[prime],[action,thriller,drama,war]).
movie(inception,christopher_nolan,pg13,148,[netflix],[action,adventure,sci-fi,thriller]).
movie(insomnia,christopher_nolan,r,118,[prime],[drama,mystery,thriller]).
movie(prestige,christopher_nolan,pg13,130,[hbogo],[drama,mystery,sci-fi]).
movie(notting_hill,roger_michell,pg13,124,[netflix,prime],[drama,comedy,romance]).
movie(knives_out,rian_johnson,pg13,130,[prime],[comedy,mystery,drama]).
movie(contratiempo,oriol_paulo,nc-17,130,[netflix],[crime]).
movie(the_godfather,drancis_ford_coppola,r,175,[hbogo],[drama,crime]).
movie(once_upon_a_time_in_hollywood,quentin_tarantino,r,161,[netflix],[drama,comedy]).
movie(forrest_gump,robert_zemeckis,pg13,142,[netflix],[drama,romance]).
movie(inglourious_basterds,quentin_tarantino,r,153,[hbogo],[drama,action,war]).
movie(a_beautiful_mind,ron_howard,pg13,135,[hbogo,prime],[drama]).
movie(the_incredibles,brad_bird,pg,115,[hbogo,disney],[animation,action,family,comedy,sci-fi]).
movie(the_incredibles_2,brad_bird,pg,118,[hbogo,disney],[animation,action,family,comedy,sci-fi]).
movie(titanic,james_cameron,pg13,194,[hbogo],[drama,romance]).
movie(skyfall,sam_mendes,pg13,143,[hbogo],[action]).
movie(the_theory_of_everything,james_marshal,pg13,123,[netflix],[drama,romance]).
movie(joker,todd_phillips,r,122,[netflix],[drama,crime]).
movie(finding_nemo,andrew_stanton,g,100,[hbogo],[animation,comedy,family]).
movie(zodiac,david_fincher,r,157,[hbogo,netflix],[crime,drama,mystery]).
movie(tangled,nathan_greno,pg,100,[hbogo],[animation,comedy,family,romance,musical]).
movie(the_shawshank_redemption,frank_darabont,r,142,[netflix],[drama]).
movie(the_lord_of_the_rings_the_fellowship_of_the_ring,peter_jackson,pg13,130,[hbogo],[drama,mystery,sci-fi]).
movie(the_intern,nancy_meyers,pg13,121,[netflix],[drama,comedy]).
movie(kung_fu_panda,mark_osborne,pg,92,[netflix],[animation,action,comedy,family]).
movie(spirit_stallion_of_the_cimarron,kelly_asbury,g,92,[netflix],[animation,drama]).
movie(spectre,sam_mendes,pg13,148,[hbogo],[action]).
movie(the_dark_knight,christopher_nolan,pg13,152,[hbogo],[action,drama,crime]).
movie(gran_torino,clint_eastwood,r,116,[netflix],[drama]).
movie(saving_private_ryan,steven_spielberg,r,169,[netflix],[drama,war]).
movie(the_notebook,nick_cassavetes,pg13,123,[netflix],[drama,romance]).
movie(silver_linings_playbook,dawid_russell,r,122,[netflix],[comedy,drama,romance]).
movie(se7en,david_fincher,r,127,[netflix],[crime,mystery,drama]).
movie(spider_man_no_way_home, jon_watts, pg13, 148, [prime, disney], [action, adventure, fantasy, sci-fi]).
movie(no_time_to_die, cary_fukunaga, pg13, 163, [prime, hbogo], [action, adventure, thriller]).
movie(dune, denis_villeneuve, pg13, 155, [prime], [action, adventure, drama, sci-fi]).
movie(the_french_dispatch, wes_anderson, r, 107, [netflix, prime], [comedy, drama, romance]).
movie(eternals, chloe_zhao, pg13, 157, [disney], [action, adventure, drama, fantasy, sci-fi]).
movie(black_widow, cate_shortland, pg13, 134, [disney], [action, adventure, sci-fi, thriller]).
movie(shang_chi_and_the_legend_of_the_ten_rings, destin_daniel_cretton, pg13, 132, [disney], [action, adventure, fantasy]).
movie(no_sudden_move, steven_soderbergh, r, 115, [hbogo], [crime, drama, mystery, thriller]).
movie(spiral, darren_lynn_bousman, r, 93, [netflix], [crime, horror, mystery, thriller]).
movie(cruella, craig_gillespie, pg13, 134, [disney, prime], [crime, comedy, drama]).
movie(the_suicide_squad, james_gunn, r, 132, [hbogo, prime], [action, adventure, comedy, sci-fi]).
movie(west_side_story, steven_spielberg, pg13, 156, [disney], [crime, drama, musical, romance]).
movie(dont_breathe_2, rodono_safran, r, 98, [netflix], [horror, thriller]).
movie(ghostbusters_afterlife, jason_reitman, pg13, 124, [prime], [action, comedy, fantasy, sci-fi]).
movie(red_notice, rawson_marshall_thurber, pg13, 118, [netflix, prime], [action, adventure, comedy, crime]).
movie(the_matrix_resurrections, lana_wachowski, r, 148, [hbogo], [action, sci-fi]).
movie(venom_let_there_be_carnage, andy_serkins, pg13, 97, [prime], [action, adventure, fantasy, sci-fi, thriller]).
movie(hotel_transylvania_transformania, derek_drymon, pg, 87, [prime], [animation, adventure, comedy, family, fantasy]).
movie(doctor_strange_in_the_multiverse_of_madness, sam_raimi, pg13, 139, [disney], [action, adventure, fantasy, horror, sci-fi]).

%-------------------------------------------
serie(breaking_bad, vince_gilligan, r, 60, [netflix], [crime, drama, thriller]).
serie(stranger_things, matt_duffer, pg13, 50, [netflix], [drama, fantasy, horror, mystery, sci-fi, thriller]).
serie(the_crown, peter_morgan, pg13, 58, [netflix], [biography, drama, history]).
serie(the_mandalorian, jon_favreau, pg13, 40, [disney], [action, adventure, fantasy, sci-fi]).
