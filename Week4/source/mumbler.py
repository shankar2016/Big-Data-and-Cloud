#!/usr/bin/python
import sys
import re
import zipfile
import os
import random
import subprocess
import commands
import time
import datetime
from datetime import datetime

#
# word_choices_and_freq
#
# Given a set of grep based matches for a certain lead word, build a list
# of all posible follow-on words and compute a probability ofr each based
# upon the cumulative count
#
# frequency_sum is the total of weights of all the possible follow-on words
#
# Return the word list and the probability list
def word_choices_and_freq(data, num_tags, frequency_sum):

        # Create two empty lists to hold the words and the probabilities
        word_choices = []
        word_probabilities = []

        # Cycle through all the data that was returned by a grep action
        # that matched the lead-word, num_tags is the number of matched lines
        for i in range(0, num_tags):
                # Word is the field that is indexed by 1
                word_choices.append(data[i][1])

                # Weight is the field that is indexed by 2
                # Divide each by total weight to get a frequency
                word_probabilities.append(float(data[i][2])/frequency_sum)

        return(word_choices, word_probabilities)

#
# random_pick
#
# Given a list of words and a list of probabilities, randomly
# pick a new follow-on word
# Code referenced from Stackforge
#
def random_pick(word_list, probabilities):
        x = random.uniform(0, 1)
        cumulative_probability = 0.0

        # Return a random pick
        for item, item_probability in zip(word_list, probabilities):
                cumulative_probability += item_probability
                if x < cumulative_probability:
                        break

        # Next lead word chosen
        return item


#
# Search for word occurences
#
def word_occurrences(lead_word, search_file):
        # Words in database are indexed by letter
        # Grep the appropriate file for the  lead word
        cmd = 'egrep ' + '-w ' + '^' + lead_word + ' ' + '../data/'+ search_file

        # Grep all lines in the file where the lead word instance is at the head of the line
        try:
                out, err = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).communicate()
        except:
                print('No file found matching the first letter of lead word, exiting')
                return([])

        # Store all the lines returned by grep in "lines_found"
        lines_found = out.splitlines()
        return(lines_found)


#
# mumbler - the main routine
#
def mumbler():

	#
        # First check the invocation syntax and user entered fields
        #
        # Check invocation syntax and the argument formats
        if len(sys.argv) < 3:
                print("Invalid command syntax: mumbler <word> <count>")
                exit()

        # Check the lead word format
        if sys.argv[1].isalnum():
                pass
        else:
                # If the second argument has special characters, escape them
                fixed_var  = re.escape(sys.argv[1])
                if fixed_var.isalnum() == False:
                        print ("Invocation error: Second argument must be a word")
                        exit()

        # Check the count format
        if sys.argv[2].isdigit():
                pass
        else:
                print ("Invocation error:  Third argument must be number")
                exit()

        # Use convenience variables
        # Save the user requested lead word
        lead_word = sys.argv[1]

        # Play it safe and escape all special characters
        lead_word = re.escape(lead_word)

        # Bail if the word is not alphanumeric
        if lead_word[0].isalnum() == False:
                print("Latest lead word does not start with an alphanumeric or has non alphanumeric charaters, exiting")
                return

        #determine the length of the user requested wordjj
        word_length = len(lead_word)

        # User requested count
        max_count = int(sys.argv[2])
        iteration = max_count

        # Loop through max_count, use a loop counter
        iteraton = max_count

        # Keep track of the progressively determined word list using a list of lists
        mumbler_path = []

        # Keep track of processing time
        start_time = datetime.now()


        #print("Starting lead word is : ")
        print(lead_word)

        # The main loop, iterate over user requested count
        while iteration > 0:


                # Add the word to the progressively built list
                # Do it here jut in case we have to bail because of error
                mumbler_path.append(lead_word)

                # For each algorithmically determined lead word, escape all special characters
                if iteration < max_count:
                        lead_word = re.escape(lead_word)

                if lead_word[0].isalnum() == False:
                        print(lead_word[0])
                        print("Lead word does not start with an alphanumeric or or has non alphanumeric charaters, exiting")
                        break

                # Get the first letter of the lead word
                search_file = lead_word[0]

                lines_found = word_occurrences(lead_word, search_file)

                # Keep track of number of returned lines
                l = len(lines_found)

                # Often we run into words that break the mumbler chain. Recover by backing up one level
                # If the new word is not found, back up one node and re-search
                # Try only a few times, say 10
                count = 10
		while l == 0 and iteration != max_count and count > 0:

                        # The next lead word was not found, back up a node
                        print("Follow on word not found, orphan word is: ", lead_word)

                        # Load the last successful word and search file
                        lead_word = last_successful_word
                        search_file = lead_word[0]

                        print("Up node is: ", lead_word, " <-- restart walk at this node")
                        lines_found = word_occurrences(lead_word, search_file)

                        # If still no lines found, exit gracefully
                        l = len(lines_found)
                        if l > 0:
                                break;
                        count -= 1

                        # If reached a dead end, exit the program
                        if count == 0:
                                print("\n\nMumbler path is:")
                                print(mumbler_path)
                                exit()

                # if length of known list is still 0, exit gracefully
                if l == 0:
                        print("Word not found, Mumbler cannot proceed, stopping")
                        print("\n\nMumbler path is:")
                        print(mumbler_path)
                        exit()

                # Let's extract from the returned lines, split the fields
                # so that each field can be individually processed
                tags=[]

                for i in range (0, l):
                        tag = lines_found[i].split(" ")
                        tags.append(tag)

                # we no longer need the raw data, overwrite the original data with the segmented data
                lines_found = tags
                num_tags = len(lines_found)

                # Compute the overall sum of weights from all word combinations
                frequency_sum = 0
                for i in range(0, num_tags):
                        frequency_sum += int(lines_found[i][2])

                # Construct the 2 lists
                # One for possible words, another with associated probabilities
                word_choices, word_probabilities = word_choices_and_freq(lines_found, num_tags, frequency_sum)

                # Save the last search word for every subsequent loop
                # we'll use it to back up a node, if mumbler cannot find the next word
                last_successful_word = lead_word
                last_successful_file = search_file

                # choose one word
                lead_word = random_pick(word_choices, word_probabilities)

                while lead_word.isalnum() == False:
                        lead_word = random_pick(word_choices, word_probabilities)

                #print("next lead word is : ")
                print(lead_word)

                # Using the new chosen lead word, go to the next iteration
                iteration -= 1


        # We are done with looping, print the mumbler path
        # This shows the word trail
        print("\n\nMumbler path is:")
        print(mumbler_path)
        end_time = datetime.now()
        delta_time =  end_time-start_time
        print("Mumbler time: ")
        print(delta_time)



if __name__ == "__main__":
        mumbler()
