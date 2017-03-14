start=0;
end=10;
for ((i=start; i<=end; i++ ))
        do
                # upload files from Softlayer Objectstore
                echo "Uploading google file into SL Object Store: Iteration ${i}"
                Filesize=1674767697
                echo "File size is : " $Filesize "bytes"
                START=$(date +%s)
                echo "Iteration ${i} Write start timestamp is :" $START
                swift upload container1 ../download/googlebooks-eng-all-2gram-20090715-99.csv --os-auth-token AUTH_tk87f94aefd6074dd29ae2636e2fc42939  --os-storage-url https://dal05.objectstorage.service.networklayer.com/v1/AUTH_f8514a61-4c41-4f52-a413-b2e308db0da0

                END=$(date +%s)
                echo "Iteration ${i} Write end time is :" $END
                DIFF=$((($END) - ($START)))
                echo "Time for this Iteration ${i} WRITE is : " $DIFF "seconds (rounded)"

                echo "File WRITE rate is " $(($Filesize/($DIFF * 1000000))) "Mbytes/sec"
                echo " "
                echo " "

                # Read cycle
                START=$(date +%s)
                echo "Iteration ${i} Read start timestamp is :" $START
                swift download container1  --os-auth-token AUTH_tk87f94aefd6074dd29ae2636e2fc42939  --os-storage-url https://dal05.objectstorage.service.networklayer.com/v1/AUTH_f8514a61-4c41-4f52-a413-b2e308db0da0
                END=$(date +%s)
                echo "Iteration ${i} Read end timestamp is :" $END
                DIFF=$((($END) - ($START)))
                echo "Time for this Iteration ${i} READ is : " $DIFF "seconds (rounded)"

                echo "File READ rate is " $(($Filesize/($DIFF * 1000000))) "Mbytes/sec"
                echo " "
                echo " "
        done
