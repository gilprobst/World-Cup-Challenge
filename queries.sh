#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals+opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals+opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(round) FROM games WHERE winner_goals>2")"

echo -e "\nWinner of the 2018 tournament team name:"
winner_id=$($PSQL "SELECT winner_id FROM games WHERE year=2018 AND round='Final'")
echo "$($PSQL "SELECT name FROM teams WHERE team_id=$winner_id")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
#w_eigths_id=array{$($PSQL "SELECT winner_id FROM games WHERE year=2014 AND round='Eighth-Final'")}
#echo $w_eigths_id
#echo "$($PSQL "SELECT opponent_id FROM games WHERE year=2014 AND round='Eighth-Final'")"
#eights_id=( $($PSQL "SELECT array(winner_id FROM games WHERE year=2014 AND round='Eighth-Final')") )
#echo $eigths_id
#echo -e "$($PSQL "SELECT winner_id FROM games WHERE year=2014 AND round='Eighth-Final'")""\n""$($PSQL "SELECT opponent_id FROM games WHERE year=2014 AND round='Eighth-Final'")"
eights="$($PSQL "SELECT t1.name,t2.name FROM games FULL JOIN teams AS t1 ON games.winner_id = t1.team_id FULL JOIN teams AS t2 ON games.opponent_id = t2.team_id WHERE round='Eighth-Final' AND year=2014")"
echo "$($PSQL "SELECT name FROM games INNER JOIN teams ON games.winner_id=teams.team_id OR games.opponent_id=teams.team_id WHERE (year=2014 AND round='Eighth-Final') ORDER BY name")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(name) FROM teams FULL JOIN games ON teams.team_id=games.winner_id WHERE winner_id IS NOT NULL ORDER BY name")"

echo -e "\nYear and team name of all the champions:"
#winners_id=$($PSQL "SELECT winner_id FROM games WHERE round='Final'")
#for i in $($winners_id); do echo "$($PSQL "SELECT name FROM teams WHERE team_id=$i")"; done
echo "$($PSQL "SELECT year, name FROM games FULL JOIN teams ON games.winner_id=teams.team_id WHERE (winner_id IS NOT NULL AND round='Final') GROUP BY year, name")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"
