# FCC_RelationalDB_number_guessing_game

This is my solution for the [**Number Guessing Game**](https://www.freecodecamp.org/learn/relational-database/build-a-number-guessing-game-project/build-a-number-guessing-game)
required project for the [**freeCodeCamp's Relational Databases Certification**](https://www.freecodecamp.org/learn/relational-database/) using PostgreSQL and bash. <br />

## Contents
- [Table](#table)
    - [number_guess](#number_guess)
- [Number Guessing Script](#number-guessing-script)   
- [Project tasks](#project-tasks)

## Table
The database can be rebuilt by entering `psql -U postgres < number_guess.sql` in a terminal where the `.sql` file is.\
Rebuilding the database using this file will result in the following table: <br />

### number_guess

|username_id <sup>1</sup>|	username <sup>2</sup>|	games_played <sup>3</sup>| best_game<sup>4</sup>|	
|:----------------------:|:---------------------:|:-------------------------:|:--------------------:|
|                        |                       |                           |                      |

<sup>1</sup> serial, primary key, not null\
<sup>2</sup> varchar(22)\
<sup>3</sup> int, default 0\
<sup>4</sup> int, default 999999999

[<sub>Back to top</sub>](#top)

## Number Guessing Script
It can be accessed by inputting ./number_guess.sh in the terminal.\
The script will print in the terminal:
> Enter your username:

The user must input their username.

<br />

If the script doesn't find the username in the [number_guess](#number_guess) table, the script will create that username in the same table, and print in the terminal:
> Welcome, [username]! It looks like this is your first time here.

<br />

Otherwise, if the script finds the username in the [number_guess](#number_guess) table, it will print in the terminal:
> Welcome back, [username]! You have played [games_played] games, and your best game took [best-game] guesses.

<br />

After the above steps, the script will generate a random secret number between 1 and 1000 and print in the terminal:
> Guess the secret number between 1 and 1000:

The user should type a number.

<br />

If the user's guess is not an integer, the script will print the below message and repeat the guessing prompt. Since the input was considered invalid, it doesn't count toward the user's total number of guesses.
> That is not an integer, guess again:

<br />

If the user's guess is higher than the secret number, the script will:
- print the below message:
  > It's lower than that, guess again:
- add 1 to the number of guesses
- wait for a new input

<br />

If the user's guess is lower than the secret number, the script will:
- print the below message:
  > It's higher than that, guess again:
- add 1 to the number of guesses
- wait for a new input

<br />

If the user's guess matches the secret number, the script will:
- add 1 to the number of guesses
- update the number of games_played on the [number_guess](#number_guess) table by increasing the current number by 1
- if the number of guesses of this current game is lower than the number recorded under best_game on the [number_guess](#number_guess) table, the number will be updated to this new best game. Otherwise, it remains the same
- print the below message and exit:
  > You guessed it in [number_of_guesses] tries. The secret number was [number]. Nice job!

[<sub>Back to top</sub>](#top)

## Project Tasks
The goal was to create a database in PostgreSQL and a script in bash that passed the following tests \
(more details available on [**Number Guessing Game**](https://www.freecodecamp.org/learn/relational-database/build-a-number-guessing-game-project/build-a-number-guessing-game)):
- Create a `number_guessing_game` folder in the `project` folder for your program
- Create `number_guess.sh` in your `number_guessing_game` folder and give it executable permissions
- Your script should have a shebang at the top of the file that uses `#!/bin/bash`
- Turn the `number_guessing_game` folder into a git repository
- Your git repository should have at least five commits
- Your script should randomly generate a number that users have to guess
- When you run your script, you should prompt the user for a username with `Enter your username:`, and take a username as input. Your database should allow usernames that are 22 characters
- If that username has been used before, it should print `Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses.`, with `<username>` being a users name from the database, `<games_played>` being the total number of games that user has played, and `<best_game>` being the fewest number of guesses it took that user to win the game
- If the username has not been used before, you should print `Welcome, <username>! It looks like this is your first time here.`
- The next line printed should be `Guess the secret number between 1 and 1000:` and input from the user should be read
- Until they guess the secret number, it should print `It's lower than that, guess again:` if the previous input was higher than the secret number, and `It's higher than that, guess again:` if the previous input was lower than the secret number. Asking for input each time until they input the secret number.
- If anything other than an integer is input as a guess, it should print `That is not an integer, guess again:`
- When the secret number is guessed, your script should print `You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job!` and finish running
- The message for the first commit should be `Initial commit`
- The rest of the commit messages should start with `fix:`, `feat:`, `refactor:`, `chore:`, or `test:`
- You should finish your project while on the `main` branch, your working tree should be clean, and you should not have any uncommitted changes

[<sub>Back to top</sub>](#top)
