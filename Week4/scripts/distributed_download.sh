# Run on GPFS1 ONLY

# Run the script on all 3 nodes
# Now spawn the script on all 3 nodes
        ssh -f gpfs2-shankar.shankar.net "cd /gpfs/gpfsfpo; cd scripts; ./download.sh &"
        ssh -f gpfs3-shankar.shankar.net "cd /gpfs/gpfsfpo; cd scripts; ./download.sh &"

        # In the /gpfs/gpfsfpo/scripts directory
        ./download.sh


# NEED TO SLEEP FOR 60 MINUTES TO ALLOW DOWNLOAD TO COMPLETE
