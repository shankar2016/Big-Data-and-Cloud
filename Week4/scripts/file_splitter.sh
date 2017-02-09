# store all lines that being with each of 26 letters
# Files are put in the /gpfs/gpfsfpo/data directory
awk '{ print $0 >> toupper(substr($0,0,1))}' datafile.master

# store all the number files also, run in data directory
awk '/^[0-9]/ {print $0 >> substr($0,0,1)}' ../data/datafile.master

# remove all tabs, run in data directory
#sed -i $'s/\t/ /g' *

# Only keep alpha numerics in column 2
# awk '$2 ~ !/[^[:alnum:]]+$/ {print $0 >> substr($0,0,1)}' ../data/*
