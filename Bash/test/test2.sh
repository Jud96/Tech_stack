#!/bin/bash
## Check if the numbers are equal or not
read -p "Enter the first number: " num1
read -p "Enter the second number: " num2

if test "$num1" -eq "$num2" 
then
   echo "$num1 is equal to $num2"
else
   echo "$num1 is not equal to $num2"
fi