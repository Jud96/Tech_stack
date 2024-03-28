#!/bin/bash

read -p "Enter number of questions: " num

for((i=1 ; i<=$num ; i++))
do 
    num1=$((RANDOM%10))
    num2=$((RANDOM%10))
    op=$((RANDOM%4))
    if [ $op -eq 0 ]
    then
        echo -n "$num1 + $num2 = "
        read ans
        if [ $ans -eq $((num1+num2)) ]
        then
            echo "Correct"
        else
            echo "Incorrect"
        fi
    elif [ $op -eq 1 ]
    then
        echo -n "$num1 - $num2 = "
        read ans
        if [ $ans -eq $((num1-num2)) ]
        then
            echo "Correct"
        else
            echo "Incorrect"
        fi
    elif [ $op -eq 2 ]
    then
        echo -n "$num1 * $num2 = "
        read ans
        if [ $ans -eq $((num1*num2)) ]
        then
            echo "Correct"
        else
            echo "Incorrect"
        fi
    else
        echo -n "$num1 / $num2 = "
        read ans
        if [ $ans -eq $((num1/num2)) ]
        then
            echo "Correct"
        else
            echo "Incorrect"
        fi
    fi
done

# modify code to add a score and display it at the end of the quiz
# modify code to add a timer and display the time taken to complete the quiz
# modify code to add a feature to display the correct answer if the user answers incorrectly
