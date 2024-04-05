#! /bin/bash
if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS
do
 if [[ $YEAR != "year" ]]
  then
    W_EXIST=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
    if [[ -z $W_EXIST ]]
    then
      INSERT_GAME_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    fi
    O_EXIST=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
    if [[ -z $O_EXIST ]]
    then
      INSERT_GAME_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
    fi


  fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS
do
 if [[ $YEAR != "year" ]]
  then
    W_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    O_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR, '$ROUND',$W_ID,$O_ID, $W_GOALS,$O_GOALS)")
  fi
done