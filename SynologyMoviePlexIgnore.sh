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

LOG="/root/cron/create_plex_ignore_movies.log"
DIRECTORY="/volume1/Films"

#_____BEGIN_________________________________________________________________________________________

echo "---------- BEGIN ----------" >> $LOG
cd "$DIRECTORY"

echo `date "+%d.%m.%Y %H:%M:%S"` "---I--- : ROOT Folder :" `pwd` >> $LOG

if [ -e "$DIRECTORY"/.plexignore ]
then
	echo `date "+%d.%m.%Y %H:%M:%S"` "---I--- : .plexignore file existing & deleted" >> $LOG
	rm "$DIRECTORY"/.plexignore
else
	echo `date "+%d.%m.%Y %H:%M:%S"` "---I--- : .plexignore file does not exist" >> $LOG
fi

for D in "$DIRECTORY"/*/
do
    cd "${D}"
    echo `date "+%d.%m.%Y %H:%M:%S"` "---I--- : Current folder :" `pwd` >> $LOG
 
	AVIEXISTS=`ls *.avi | wc -l`
	MKVEXISTS=`ls *.mkv | wc -l`
	if [ "${AVIEXISTS}" -eq 1 ]
	then
		echo `date "+%d.%m.%Y %H:%M:%S"` "---I--- : An AVI version of this movie exists : YES" >> $LOG
		
		if [ "${MKVEXISTS}" -eq 1 ]
		then
			echo `date "+%d.%m.%Y %H:%M:%S"` "---I--- : A MKV version of this movie exists : Yes - Adding the AVI filename in the .plexignore file"  >> $LOG
			ls *.avi >> "$DIRECTORY"/.plexignore
		else
			echo `date "+%d.%m.%Y %H:%M:%S"` "---I--- : A MKV version of this movie exists : No - .plexignore file not modified"  >> $LOG
		fi
	fi
done

#_____END__________________________________________________________________________________________

echo "---------- END ----------" >> $LOG
echo "" >> $LOG