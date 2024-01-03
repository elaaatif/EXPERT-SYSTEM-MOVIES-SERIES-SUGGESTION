# Prolog Movie and Series Recommendation System

This Prolog project is a movie and series recommendation system that suggests personalized movies or series based on user preferences such as age, mood, preferred director, and streaming platform. The system utilizes a fact base of movies and series, and it allows users to input their criteria to receive recommendations.

**Contents**


- Prerequisites

Prolog interpreter (e.g., SWI-Prolog) installed on your machine.

- Usage

- [ ] Clone the repository to your local machine.

- [ ] Open the Prolog interpreter in the terminal.

- [ ] Load the main Prolog file: consult('recommendation_system.pl').

- [ ] Run the recommendation system: suggest_movie_or_serie(M).

- Project Structure

recommendation_system.pl: The main Prolog file containing predicates for recommendation and user interaction, as well as the fact base of movies and series.

- Features

> - [ ]  User-friendly interface for inputting preferences.

> - [ ] Personalized movie and series recommendations based on user criteria.

> - [ ] Modular design for easy maintenance and updates.


- How It Works

The user provides input for age, mood, director, streaming platform, and other preferences.
The recommendation system queries the databases of movies and series to generate personalized suggestions.
The system utilizes Prolog predicates to filter and recommend movies or series based on user criteria.

- Example Usage

prolog :




```
?- suggest_movie_or_serie(M).
Choose one option:
   1. Movie
   2. Short Series
|: 1.
Type your age: |: 20.
Choose your mood: 
   happy   sad   angry   scared
|: happy.
Choose a director from:
List of Movie Directors:
ridley_scott
andrew_adamson
taika_waititi
george_lucas
zack_snyder
steven_spielberg
richard_lester
bernardo_bertolucci
christopher_nolan
roger_michell
rian_johnson
oriol_paulo
francis_ford_coppola
quentin_tarantino
robert_zemeckis
ron_howard
brad_bird
james_cameron
sam_mendes
james_marshal
todd_phillips
andrew_stanton
david_fincher
nathan_greno
frank_darabont
peter_jackson
nancy_meyers
mark_osborne
kelly_asbury
clint_eastwood
nick_cassavetes
david_russell
|: kelly_asbury.
Choose your streaming platform: 
   netflix   hbogo   prime   disney : 
|: netflix.
Type minimum length of film in minutes: |: 20.
Type maximum length of film in minutes: |: 180.
Choose the origin: 
   usa   uk  .... 
|: usa.
Choose the main actor's gender: 
   male   female   diverse
|: male.
M = [spirit_stallion_of_the_cimarron]
```
