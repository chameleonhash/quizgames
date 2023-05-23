#!/bin/bash

# A function to display the quiz question
function quiz_question {
  # Randomly pick a state and its capital
  state_index=$((RANDOM % 50))
  capital=${capital_array[$state_index]}
  state=${state_array[$state_index]}

  # Create the multiple choice options
  options=($capital)
  while [[ ${#options[@]} -lt 4 ]]; do
    random_index=$((RANDOM % 50))
    if [[ ${capital_array[$random_index]} != $capital ]]; then
      options+=(${capital_array[$random_index]})
    fi
  done

  # Shuffle the multiple choice options
  options=($(echo "${options[@]}" | tr ' ' '\n' | sort -R | tr '\n' ' '))

  # Display the quiz question
  echo "What is the capital of $state?"
  for i in "${!options[@]}"; do
    echo "$((i + 1)). ${options[$i]}"
  done
}

# An array of state names
state_array=(Alabama Alaska Arizona Arkansas California Colorado Connecticut Delaware Florida Georgia Hawaii Idaho Illinois Indiana Iowa Kansas Kentucky Louisiana Maine Maryland Massachusetts Michigan Minnesota Mississippi Missouri Montana Nebraska Nevada New_Hampshire New_Jersey New_Mexico New_York North_Carolina North_Dakota Ohio Oklahoma Oregon Pennsylvania Rhode_Island South_Carolina South_Dakota Tennessee Texas Utah Vermont Virginia Washington West_Virginia Wisconsin Wyoming)

# An array of state capitals
capital_array=(Montgomery Juneau Phoenix Little Rock Sacramento Denver Hartford Dover Tallahassee Atlanta Honolulu Boise Springfield Indianapolis Des_Moines Topeka Frankfort Baton_Rouge Augusta Annapolis Boston Lansing Saint_Paul Jackson Jefferson_City Helena Lincoln Carson_City Concord Trenton Santa_Fe Albany Raleigh Bismarck Columbus Oklahoma_City Salem Harrisburg Providence Columbia Pierre Nashville Austin Salt_Lake_City Montpelier Richmond Olympia Charleston Madison Cheyenne)

# Keep playing until the user decides to quit
while true; do
  quiz_question

  # Ask for user's answer
  read -p "Enter the number of your answer: " user_answer

  # Check if the answer is correct
  if [[ ${options[$((user_answer - 1))]} == $capital ]]; then
    echo "Correct!"
  else
    echo "Incorrect. The correct answer is $capital."
  fi

  # Ask if the user wants to play again
  read -p "Do you want to play again? [y/n] " play_again
  if [[ $play_again != "y" ]]; then
    break
  fi
done
