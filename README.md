Prolog Movie and Series Recommendation System
Overview
This Prolog project serves as a movie and series recommendation system, offering personalized suggestions based on user preferences. Users can input criteria such as age, mood, preferred director, and streaming platform to receive tailored recommendations. The system utilizes a Prolog database of movies and series to generate suggestions.

Table of Contents
Prerequisites
Usage
Project Structure
Features
How It Works
Example Usage

Ensure you have a Prolog interpreter (e.g., SWI-Prolog) installed on your machine.

Usage
Clone the repository to your local machine.
Open the Prolog interpreter in the terminal.
Load the main Prolog file: consult('recommendation_system.pl').
Run the recommendation system: suggest_movie_or_serie(M).
Project Structure
recommendation_system.pl: Main Prolog file with recommendation and user interaction predicates.
movies.pl: Database of movies.
series.pl: Database of series.
Features
User-friendly interface for inputting preferences.
Personalized movie and series recommendations based on user criteria.
Modular design for easy maintenance and updates.
How It Works
The user provides input for age, mood, director, streaming platform, and other preferences.
The recommendation system queries the databases of movies and series to generate personalized suggestions.
The system utilizes Prolog predicates to filter and recommend movies or series based on user criteria.
Example Usage

```
?- suggest_movie_or_serie(M).
Choose one option:
   1. Movie
   2. Short Series
1.      % User chooses Movie
Type your age: 25.
Choose your mood:
   happy   sad   angry   scared
happy.
Choose a director from:
    (List of directors)
Christopher Nolan.
Choose your streaming platform:
   netflix   hbogo   prime   disney:
netflix.
Type minimum length of film in minutes: 120.
Type maximum length of film in minutes: 180.

M = [interstellar, tenet, inception, the_dark_knight, the_prestige, memento, dunkirk].
```
