HOST="localhost"
Port="5432"
Database="uni"
USERNAME="docker"
passwword="docker"
# export PGPASSFILE= '.pgpass'
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
db_dump=db_dump.$current_time
echo $db_dump
# -W
ARRAY=( $(psql -h $HOST -U $USERNAME  -d $Database   -c "SELECT datname FROM pg_database;") )
EXCLUDE_DB=( "template0" "template1" "postgres" ) # create array of databases that needs to be excluded
for ((i=2; i<${#ARRAY[@]}-2; i++)) # first 2 and last 2 is not db names
do
    echo ${ARRAY[i]}
done