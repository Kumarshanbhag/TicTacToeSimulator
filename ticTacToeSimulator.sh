#!/bin/bash 
echo "Welcome To Tic Tac Toe Game"

declare -a  boardOfGame

#Constant
count=1

#Displays Board
function displayBoard()
{  
	echo "  |---|---|---| "
	for (( counter=1 ; counter<=9 ; counter=$(($counter+3)) ))
	do
		echo "  | ${boardOfGame[$counter]} | ${boardOfGame[$((counter+1))]} | ${boardOfGame[$((counter+2))]} | "
		echo "  |---|---|---|"
	done
}

#Resets Board Values 
function resetBoard() {
	for((cell=1;cell<=9;cell++))
	do
		boardOfGame[$cell]=$cell
	done
}

#Player Gets Letter Assigned X or O
function assignSymbol()
{
	if((RANDOM%2==1))
	then
		PLAYER=X
		COMPUTER=O
		flag=1
		echo "Player First Turn"
	else
		PLAYER=O
		COMPUTER=X
		flag=0
		echo "Computer First Turn"
	fi
	echo "Player Letter = $PLAYER"
	play
}

#Player Plays game to selecting Position
function play() {
	if(($flag==1))
	then
		read -p "Enter Your Position Of Choice:" position
		positionOccupy $position $PLAYER
	elif(($flag==0))
	then
		smartComputerAndWinCondition $COMPUTER 'smartCheck'
		smartComputerAndWinCondition $PLAYER 'smartCheck'
		smartCorner
		positionOccupy 5 $COMPUTER
		smartSide
	fi
	play
}

#All 24 winning and 24 Blocking and 8 Winning possibilities are passed as parameter 
function smartComputerAndWinCondition() {
	letter=$1
	functionName=$2
	j=0
	for((i=1;i<=3;i++))
	do
		$functionName $(($i+$j)) $(($i+$j+1)) $(($i+$j+2)) $letter
		$functionName $(($i)) $(($i+3)) $(($i+6)) $letter
		j=$(($j+2)) 
	done
	$functionName 1 5 9 $letter 
	$functionName 3 5 7 $letter
}

#All 24 winning and Blocking possibilities are checked for computer
function smartCheck() {
	letter=$4
	if [ ${boardOfGame[$1]} == $letter ] && [ ${boardOfGame[$2]} == $letter ]
	then
		cposition=$3
		positionOccupy $cposition $COMPUTER
	elif [ ${boardOfGame[$1]} == $letter ] && [ ${boardOfGame[$3]} == $letter ]
	then
		cposition=$2
		positionOccupy $cposition $COMPUTER
	elif [ ${boardOfGame[$2]} == $letter ] && [ ${boardOfGame[$3]} == $letter ]
	then
		cposition=$1
		positionOccupy $cposition $COMPUTER
	fi
}

#Checks for available corner
function smartCorner() {
	i=1
	while(($i<=9))
	do
		positionOccupy $i $COMPUTER
		if(($i==3))
		then
			i=$(($i+2))
		fi
		i=$(($i+2))
	done
}

#Checks for available side 
function smartSide() {
	for(( i=2; i<=8; i=$(($i+2)) ))
	do
		positionOccupy $i $COMPUTER
	done
}

#Checks for non occupied position
function positionOccupy() {
	local position=$1
	local letter=$2
	if(($position>=1 && $position<=9 ))
	then
		if((${boardOfGame[$position]}!=$PLAYER && ${boardOfGame[$position]}!=$COMPUTER ))
		then
			((count++))
			boardOfGame[$position]=$letter
			displayBoard
			smartComputerAndWinCondition $letter 'checkWin'
			changeTurn 
		else
			echo "Position Occupied"
		fi
	else
		echo "Invalid Position"
	fi
}

#Player And Computer change turn
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
		if [ ${boardOfGame[$1]} == $PLAYER ]
		then	
			echo "Player Wins"
			exit
		elif [ ${boardOfGame[$1]} == $COMPUTER ]
		then
			echo "Computer Wins"
			exit
		fi
	fi
}

resetBoard
displayBoard
assignSymbol
