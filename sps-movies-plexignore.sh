#!/bin/bash

####################################################################################################
# SUMARY :                                                                                         #
#    This script generate the file /volume1/Films/.plexignore                                      #
# PREREQUISITES :                                                                                  #
#    1. The directory /volume1/Films has to have one folder by movie,                              #
#    2. Two versions of the movie have to exist on theses folders :                                #
#       a) The SD (Standard Definition) version as an AVI file,                                    #
#       b) The HD (High Definition) version as a MKV file, if possible.                            #
#       NO OTHER EXTENSION ALLOWED WITH THIS SCRIPT.                                               #
####################################################################################################

#_____VAR___________________________________________________________________________________________

LOG="/volume1/Plex/cron/sps-movies-plexignore.log"
DIRECTORY="/volume1/Films"

#_____BEGIN_________________________________________________________________________________________

echo "---------- BEGIN ----------" >> $LOG
cd "$DIRECTORY" || exit

echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : ROOT Folder :" "$(pwd)" >> $LOG

if [ -e "$DIRECTORY"/\@eaDir ]
then
	rm -rf "$DIRECTORY"/\@eaDir
fi

if [ -e "$DIRECTORY"/.plexignore ]
then
	echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : .plexignore file existing & deleted" >> $LOG
	mv "$DIRECTORY"/.plexignore "$DIRECTORY"/.plexignore.bak
else
	echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : .plexignore file does not exist" >> $LOG
fi

for D in "$DIRECTORY"/*/
do
	cd "${D}" || exit
	echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : Current folder :" "$(pwd)" >> $LOG
 
	AVIEXISTS=$(find . -type f -name "*.avi" | wc -l 2>&1)
	MKVEXISTS=$(find . -type f -name "*.mkv" | wc -l 2>&1)
	if [ "${AVIEXISTS}" -eq 1 ]
	then
		echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : An AVI version of this movie exists : YES" >> $LOG
		
		if [ "${MKVEXISTS}" -eq 1 ]
		then
			echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : A MKV version of this movie exists : Yes - Adding the AVI filename in the .plexignore file"  >> $LOG
			find . -type f -name "*.avi" | cut -c 3- >> "$DIRECTORY"/.plexignore 2>&1
		else
			echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : A MKV version of this movie exists : No - .plexignore file not modified"  >> $LOG
		fi
	fi
done

if [ -e "$DIRECTORY"/.plexignore.bak ]
then
	echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : DIFF between the previous plexignore and the current :" >> $LOG
	diff "$DIRECTORY"/.plexignore.bak "$DIRECTORY"/.plexignore >> $LOG
	rm "$DIRECTORY"/.plexignore.bak
fi

#_____END__________________________________________________________________________________________

echo "---------- END ----------" >> $LOG
echo "" >> $LOG
