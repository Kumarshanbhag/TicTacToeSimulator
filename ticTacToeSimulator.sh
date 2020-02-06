#!/bin/bash -x
echo "Welcome To Tic Tac Toe Game"

declare -a  boardOfGame

#Displays Board
function displayBoard()
{  
	i=0;
	echo "  |---|---|---| "
	for (( counter=1 ; counter<=3 ; counter++ ))
	do
		echo "  | ${boardOfGame[$((counter+$i))]} | ${boardOfGame[$((counter+$i+1))]} | ${boardOfGame[$((counter+$i+2))]} | "
		echo "  |---|---|---|"
		i=$(($i+2))
	done
}

#Resets Board Values 
function resetBoard() {
	for((i=1;i<=9;i++))
	do
		boardOfGame[$i]=$i
	done
}

#Player Gets Letter Assigned X or O
function playerLetter()
{
	if((RANDOM%2==1))
	then
		PLAYER=X
	else
		PLAYER=O
	fi
	echo "Player Letter = $PLAYER"
	firstChance
}

#Toss to check who plays first
function firstChance() {
	if((RANDOM%2==1))
	then
		echo "Player First Turn"
	else
		echo "Player First Turn"
	fi
}

resetBoard
displayBoard
playerLetter
