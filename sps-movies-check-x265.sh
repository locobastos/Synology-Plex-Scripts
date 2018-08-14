#!/bin/bash

####################################################################################################
# UNFINISHED SCRIPT !!!!!!                                                                         #
# SUMARY :                                                                                         #
#    This script check each file on /volume1/Films/ and write the filename of the file if the      #
#    video codec is x265. Plex does not support x265 yet (13 August 2018)                          #
# PREREQUISITES :                                                                                  #
#    1. MediaInfo installed in /usr/local/mediainfo/bin/                                           #
####################################################################################################

#_____VAR___________________________________________________________________________________________

LOG="/volume1/Plex/cron/sps-movies-check-x265.log"
DIRECTORY="/volume1/Films"

#_____BEGIN_________________________________________________________________________________________

echo "---------- BEGIN ----------" >> $LOG
cd "$DIRECTORY" || exit

echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : ROOT Folder :" "$(pwd)" >> $LOG

if [ -e "$DIRECTORY"/\@eaDir ]
then
	rm -rf "$DIRECTORY"/\@eaDir
fi

for D in "$DIRECTORY"/*/
do
	cd "${D}" || exit
	echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : Current folder :" "$(pwd)" >> $LOG
	
	# Check if the directory @eaDir exists
	if [ -e \@eaDir ]
	then
		rm -rf \@eaDir
	fi

	# Check each file
	find . -type f \ 
		-exec echo -n "$(date '+%d.%m.%Y %H:%M:%S')" "---I--- Checking : " \; \
		-exec /usr/local/mediainfo/bin/mediainfo --Inform="General;%CompleteName%" {} \; \
		-exec echo -n "$(date '+%d.%m.%Y %H:%M:%S')" "---I--- Codec ID : " \; \
		-exec /usr/local/mediainfo/bin/mediainfo --Inform="Video;%CodecID%" {} \;
done

#_____END__________________________________________________________________________________________

echo "---------- END ----------" >> $LOG
echo "" >> $LOG
