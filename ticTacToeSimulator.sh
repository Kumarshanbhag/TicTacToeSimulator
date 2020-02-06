#!/bin/bash
echo "Welcome To Tic Tac Toe Ga
me"

declare -a  boardOfGame

#Constant
count=1

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
		COMPUTER=O
	else
		PLAYER=O
		COMPUTER=X
	fi
	echo "Player Letter = $PLAYER"
	firstChance
}

#Toss to check who plays first
function firstChance() {
	if((RANDOM%2==1))
	then
		flag=1
		echo "Player First Turn"
	else
		flag=0
		echo "Computer First Turn"
	fi
	play
}

#Player Plays game to xelecting Position
function play() {
	if(($flag==1))
	then
		read -p "Enter Your Position Of Choice:" position
		positionOccupy $position $PLAYER
	elif(($flag==0))
	then
		cposition=$((RANDOM%9+1))
		positionOccupy $cposition $COMPUTER
	fi
	play
}

#Checks for non occupied position
function positionOccupy() {
	local position=$1
	local letter=$2
	if((${boardOfGame[$position]}!=$PLAYER && ${boardOfGame[$position]}!=$COMPUTER ))
	then
		((count++))
		boardOfGame[$position]=$letter
		displayBoard
		winCondition
		changeTurn 
	fi
}

#Passes 8 winning position as parameter
function winCondition() {
	j=0
	for((i=1;i<=3;i++))
	do
		checkWin $(($i+$j)) $(($i+$j+1)) $(($i+$j+2)) 
		checkWin $(($i)) $(($i+3)) $(($i+6)) 
		j=$(($j+2)) 
	done
	checkWin 1 5 9 
	checkWin 3 5 7 
}

function changeTurn() {
   if(($count<=9))
   then
      if((flag==1))
      then
         flag=0
      elif((flag==0))
      then
         flag=1
      fi
      play
   else
      echo "Game Tied"
      exit
   fi
}


#Checks All Winning Condition
function checkWin() {
	if [ ${boardOfGame[$1]} == ${boardOfGame[$2]} ] && [ ${boardOfGame[$2]} == ${boardOfGame[$3]} ]
	then
		echo "${boardOfGame[$1]} Wins"
		exit
	fi
}

resetBoard
displayBoard
playerLetter
