#!/usr/bin/env bash

# Natarajan Shankar 01/27/2017
# SETUP AND PREPROCESSING HAPPENS VIA THIS FILE
#


echo "Initializing setup"

#node1_addr="169.53.128.114"
node1_addr="10.122.122.68"
node1_name="gpfs1-shankar"
#node2_addr="169.53.128.116"
node2_addr="10.122.122.70"
node2_name="gpfs2-shankar"
#node3_addr="169.53.128.117"
node3_addr="10.122.122.73"
node3_name="gpfs3-shankar"

export node1_addr node2_addr node3_addr
export node1_name node2_name node3_name

echo "Node addresses defined and exported"

# Use the iMac name to test locally
# Expand the hostname check to the GPFS Cluster
case `hostname` in
        "iMac.local")
#      echo `hostname`;
       start=0;
        end=0;
   ;;
        "gpfs1-shankar.shankar.net")
#       echo `hostname`;
        start=0;
        end=32;
        node="gpfs1-shankar";
   ;;
        "gpfs2-shankar.shankar.net")
#       echo `hostname`;
        start=33;
        end=66;
        node="gpfs2-shankar";
   ;;
        "gpfs3-shankar.shankar.net")
#       echo `hostname`;
        start=67;
        end=99;
        node="gpfs3-shankar";
   ;;
esac

echo "Starting download - from google site"


# Depending on host where this script is running, download only one-third of the files
# iMac.local is used for testing only
if [ "$HOSTNAME" == gpfs1-shankar.shankar.net ]
    then
        # if [ -d download ]; then rm -Rf download; echo "Removed the download directory"; fi
        for ((i=start; i<=end; i++ ))
        do
                # download files from Google, only a 30% set per node
                echo "Downloading file tagged with ${i}"
                wget -P ../download http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-2gram-20090715-$i.csv.zip

        done


elif [ "$HOSTNAME" == gpfs2-shankar.shankar.net ]
    then
        # if [ -d download ]; then rm -Rf download; echo "Removed the download directory"; fi
        for ((i=start; i<=end; i++ ))
        do
                # download files from Google, only a 30% set per node
                echo "Downloading file tagged with ${i}"
                wget -P ../download http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-2gram-20090715-$i.csv.zip

        done


elif [ "$HOSTNAME" == gpfs3-shankar.shankar.net ]
    then
        # if [ -d download ]; then rm -Rf download; echo "Removed the download directory"; fi
        for ((i=start; i<=end; i++ ))
        do
                # download files from Google, only a 30% set per node
		Last login: Thu Feb  9 11:44:08 on ttys000
iMac:~ NatarajanShankar$ !ssh
ssh root@169.53.128.115
root@169.53.128.115's password: 
Last login: Thu Feb  9 08:57:18 2017 from c-73-223-185-251.hsd1.ca.comcast.net
[root@gpfs1-shankar ~]# 
[root@gpfs1-shankar ~]# 
[root@gpfs1-shankar ~]# 
[root@gpfs1-shankar ~]# cd /gpfs/gpfsfpo/
[root@gpfs1-shankar gpfsfpo]# ls -la
total 2044405
drwxr-xr-x. 11 root root     262144 Feb  8 11:09 .
drwxr-xr-x.  4 root root       4096 Jan 31 01:22 ..
-rw-r--r--.  1 root root          0 Jan 31 01:23 aa
drwxr-xr-x.  2 root root       4096 Feb  8 13:54 data
-rw-r--r--.  1 root root 2092911827 Feb  3 17:39 datafile.master
drwxr-xr-x.  2 root root       4096 Feb  8 09:43 data_old
drwxr-xr-x.  2 root root       4096 Feb  8 09:46 data_old_II
-rw-r--r--.  1 root root        390 Feb  3 17:39 distributed_download.sh
drwxr-xr-x.  2 root root      16384 Feb  4 14:25 download
-rwxr--r--.  1 root root       7756 Feb  3 17:39 download.sh
-rwxr--r--.  1 root root         87 Feb  3 17:39 file_splitter.sh
drwxr-xr-x.  2 root root       4096 Jan 31 19:11 gpfs1
drwxr-xr-x.  2 root root       4096 Jan 31 19:11 gpfs2
drwxr-xr-x.  2 root root       4096 Jan 31 19:11 gpfs3
-rwxr--r--.  1 root root        574 Feb  3 17:39 mumbler_optimizer.sh
drwxr-xr-x.  3 root root     262144 Feb  8 10:17 scripts
dr-xr-xr-x.  2 root root       8192 Dec 31  1969 .snapshots
drwxr-xr-x.  2 root root       4096 Feb  9 12:06 source
[root@gpfs1-shankar gpfsfpo]# cd scripts
[root@gpfs1-shankar scripts]# ls -la
total 512
drwxr-xr-x.  3 root root 262144 Feb  8 10:17 .
drwxr-xr-x. 11 root root 262144 Feb  8 11:09 ..
drwxr-xr-x.  3 root root   4096 Jan 31 02:17 ...
-rw-r--r--.  1 root root      0 Feb  4 22:13 datafile.master
-rw-r--r--.  1 root root    390 Feb  4 12:06 distributed_download.sh
-rwxr--r--.  1 root root   2655 Feb  4 12:15 download.sh
-rwxr--r--.  1 root root    467 Feb  8 10:15 file_splitter.sh
-rwxr--r--.  1 root root    674 Feb  4 14:41 mumbler_optimizer.sh
[root@gpfs1-shankar scripts]# vi distributed_download.sh 
[root@gpfs1-shankar scripts]# vi file_splitter.sh 
[root@gpfs1-shankar scripts]# vi download.sh



#node1_addr="169.53.128.114"
node1_addr="10.122.122.68"
node1_name="gpfs1-shankar"
#node2_addr="169.53.128.116"
node2_addr="10.122.122.70"
node2_name="gpfs2-shankar"
#node3_addr="169.53.128.117"
node3_addr="10.122.122.73"
node3_name="gpfs3-shankar"

export node1_addr node2_addr node3_addr
export node1_name node2_name node3_name

echo "Node addresses defined and exported"

# Use the iMac name to test locally
# Expand the hostname check to the GPFS Cluster
case `hostname` in
        "iMac.local")
#      echo `hostname`;
       start=0;
        end=0;
   ;;
        "gpfs1-shankar.shankar.net")
#       echo `hostname`;
        start=0;
        end=32;
        node="gpfs1-shankar";
   ;;
        "gpfs2-shankar.shankar.net")
#       echo `hostname`;
        start=33;
        end=66;
        node="gpfs2-shankar";
   ;;
        "gpfs3-shankar.shankar.net")
#       echo `hostname`;
        start=67;
        end=99;
        node="gpfs3-shankar";
   ;;
esac

echo "Starting download - from google site"


# Depending on host where this script is running, download only one-third of the files
# iMac.local is used for testing only
if [ "$HOSTNAME" == gpfs1-shankar.shankar.net ]
    then
        # if [ -d download ]; then rm -Rf download; echo "Removed the download directory"; fi
        for ((i=start; i<=end; i++ ))
        do
                # download files from Google, only a 30% set per node
                echo "Downloading file tagged with ${i}"
                wget -P ../download http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-2gram-20090715-$i.csv.zip

        done


elif [ "$HOSTNAME" == gpfs2-shankar.shankar.net ]
    then
        # if [ -d download ]; then rm -Rf download; echo "Removed the download directory"; fi
        for ((i=start; i<=end; i++ ))
        do
                # download files from Google, only a 30% set per node
                echo "Downloading file tagged with ${i}"
                wget -P ../download http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-2gram-20090715-$i.csv.zip

        done


elif [ "$HOSTNAME" == gpfs3-shankar.shankar.net ]
    then
        # if [ -d download ]; then rm -Rf download; echo "Removed the download directory"; fi
        for ((i=start; i<=end; i++ ))
        do
                # download files from Google, only a 30% set per node
                echo "Downloading file tagged with ${i}"
                wget -P ../download http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-2gram-20090715-$i.csv.zip

        done

fi

echo "Done downloading"
