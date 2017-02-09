# http://unix.stackexchange.com/questions/190947/sum-columns-based-on-matching-fields

# Used a variant of what is presented at that site


# Can be split and run across multiple nodes, 33/34 per node
# Code is shown as handling all 100 files
for ((file_num=0; file_num<=99; file_num++ ))
        do
                date
                echo "Unzipping and proccesing file" $file_num
                unzip -c ../download/googlebooks-eng-all-2gram-20090715-${file_num}.csv.zip | awk '{a[$1 "\t" $2]+=$3}END{for (i in a){print i,a[i]}}' >> datafile

                perl -i.bak -ne "print unless(/[^[:ascii:]]/)" datafile
                rm datafile
                perl -ne 'print if /^[0-9a-zA-Z]/' datafile.bak >> datafile.master

                rm datafile.bak

                date
        done
