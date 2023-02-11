#!/bin/bash

# A function to display the quiz question using figlet
function quiz_question {
  # Randomly pick a country and its capital
  country_index=$((RANDOM % 12))
  capital=${capital_array[$country_index]}
  country=${country_array[$country_index]}

  # Create the multiple choice options
  options=($capital)
  while [[ ${#options[@]} -lt 4 ]]; do
    random_index=$((RANDOM % 12))
    if [[ ${capital_array[$random_index]} != $capital ]]; then
      options+=(${capital_array[$random_index]})
    fi
  done

  # Shuffle the multiple choice options
  options=($(echo "${options[@]}" | tr ' ' '\n' | sort -R | tr '\n' ' '))

  # Display the quiz question using figlet
  figlet "What is the capital of $country?"
  for i in "${!options[@]}"; do
    case $i in
      0) letter="a" ;;
      1) letter="b" ;;
      2) letter="c" ;;
      3) letter="d" ;;
    esac
    echo "$letter) $(figlet "${options[$i]}")"
  done
}

# An array of country names
country_array=("Argentina" "Bolivia" "Brazil" "Chile" "Colombia" "Ecuador" "Guyana" "Paraguay" "Peru" "Suriname" "Uruguay" "Venezuela")

# An array of country capitals
capital_array=("BuenosAires" "LaPaz-or-Sucre" "Brasilia" "Santiago" "Bogota" "Quito" "Georgetown" "Asuncion" "Lima" "Paramaribo" "Montevideo" "Caracas")

# Keep playing until the user decides to quit
while true; do
  quiz_question

  # Ask for user's answer
  read -p "Enter the letter of your answer: " user_answer

  # Check if the answer is correct
  case $user_answer in
    a) selected=0 ;;
    b) selected=1 ;;
    c) selected=2 ;;
    d) selected=3 ;;
  esac
  if [[ ${options[$selected]} == $capital ]]; then
    figlet "Correct!"
  else
    figlet "Incorrect."
    echo "The correct answer is $(figlet "$capital"). "
  fi

  # Ask if the user wants to play again
  read -p "Do you want to play again? [y/n] " play_again
  if [[ $play_again != "y" ]]; then
    break
  fi
done
