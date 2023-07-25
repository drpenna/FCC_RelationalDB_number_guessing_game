#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

### USERNAME ###

#prompt for username
echo "Enter your username:"
read USERNAME

#check if username exists
USERNAME_CHECK=$($PSQL "SELECT username FROM number_guess where username='$USERNAME';")

#if username doesnt exist
if [[ -z $USERNAME_CHECK ]]
then
#welcome new user and register
echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
CREATE_USERNAME=$($PSQL "INSERT INTO number_guess(username) VALUES('$USERNAME');")
fi

#fetch user data
USERNAME_DATA=$($PSQL "SELECT username_id, games_played, best_game FROM number_guess where username='$USERNAME';")
echo $USERNAME_DATA | while IFS="|" read USERNAME_ID GAMES_PLAYED BEST_GAME
do

  #if username previously existed
  if [[ -n $USERNAME_CHECK ]]
  then
  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi
done

  ### GAME ###
    
  #generate random number between 1 and 1000
  NUMBER=$(( RANDOM % 1000 + 1 ))

  echo -e "\nGuess the secret number between 1 and 1000:"
  NUMBER_OF_GUESSES=0
  read GUESS

  GUESS_PROMPT() {
    read GUESS
  }

 
  while [[ $GUESS -ne $NUMBER ]]
  do

  #if guess is not an integer
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then echo -e "\nThat is not an integer, guess again:"
  GUESS_PROMPT
  fi

  #check guess against secret number

  #if input is higher than secret number
  if [[ $GUESS -gt $NUMBER ]]
  then
  echo -e "\nIt's lower than that, guess again:"
  NUMBER_OF_GUESSES=$(( $NUMBER_OF_GUESSES + 1 ))
  GUESS=NULL
  GUESS_PROMPT
  fi


  #if input is lower than secret number
  if [[ $GUESS -lt $NUMBER ]]
  then
  echo -e "\nIt's higher than that, guess again:"
  NUMBER_OF_GUESSES=$(( $NUMBER_OF_GUESSES + 1 ))
  GUESS=NULL
  GUESS_PROMPT
  fi

done



#if input is correct
if [[ $GUESS -eq $NUMBER ]]
then
NUMBER_OF_GUESSES=$(( $NUMBER_OF_GUESSES + 1 ))

  USERNAME_DATA=$($PSQL "SELECT username_id, games_played, best_game FROM number_guess where username='$USERNAME';")
  echo $USERNAME_DATA | while IFS="|" read USERNAME_ID GAMES_PLAYED BEST_GAME
  do
    #update number of games played
    UPDATED_GAMES_PLAYED=$(( $GAMES_PLAYED + 1 ))
    UPDATE_GAMES_PLAYED=$($PSQL "UPDATE number_guess SET games_played=$UPDATED_GAMES_PLAYED WHERE username_id=$USERNAME_ID;")

    #check if it's best game
    if [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
    then
    #update best game
    UPDATE_BEST_GAME=$($PSQL "UPDATE number_guess SET best_game=$NUMBER_OF_GUESSES where username='$USERNAME';")
    fi
  done
echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $NUMBER. Nice job!"
fi
