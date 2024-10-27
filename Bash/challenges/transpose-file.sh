#!/bin/bash
# extract name column from file and transpose it
# awk '{print $1}' file.txt | paste -d ' ' - - -
# awk '{print $2}' file.txt | paste -d ' ' - - -

# NF is the number of fields in the current record
# NR is the number of records read so far

# head -1 file.txt | wc -w | xargs seq 1 | xargs -I{} -n 1 sh -c "cut -d ' ' -f{} file1.txt | paste -sd ' ' -"


# awk '
# {
#     for (i = 1; i <= NF; i++) {
#         if (NR == 1) {
#             a[i] = $i
#         } else {
#             a[i] = a[i] " " $i
#         }
#     }
# }
# END {
#     for (i = 1; i <= NF; i++) {
#         print a[i]
#     }
# }' file.txt

for ((i = 1; ; i++)); do
    # -vn is used to pass the value of i to awk
    line=$(awk -vn=$i '{print $n}' file1.txt)
    [[ $line ]] || break # break if line is empty
    echo $line
done