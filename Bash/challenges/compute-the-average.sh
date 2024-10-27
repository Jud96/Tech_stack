
read N

sum=0
for i in $(seq 1 $N); do
    read num
    sum=$(($sum + $num))
done
average=$(echo "scale=3; $sum / $N" | bc)
echo $average | xargs printf "%.3f\n"
