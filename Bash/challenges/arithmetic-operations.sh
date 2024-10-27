
read expression 

# 5+50*3/20 + (19*2)/7

echo $expression | bc -l | xargs printf "%.3f\n"