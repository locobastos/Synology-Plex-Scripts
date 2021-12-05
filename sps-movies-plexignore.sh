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

LOG="/volume1/v3/sps-movies-plexignore.log"
NOAVI="/volume1/v3/sps-movies-noavi.log"
FILMS="/volume1/v3/Films"
FILMS_ANIMATION="/volume1/v3/Films Animation"
FILMS_ANIMATION_JP="/volume1/v3/Films Animation Japonais"

#_____BEGIN_________________________________________________________________________________________

echo "---------- BEGIN ----------" >> $LOG

#########
# FILMS #
#########
cd "$FILMS" || exit

echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : ROOT Folder :" "$(pwd)" >> $LOG

find . -type d -name "@eaDir" -exec rm -rf {} \;

if [ -e "${FILMS}/.plexignore" ]
then
    echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : .plexignore file existing & deleted" >> $LOG
    mv "${FILMS}/.plexignore" "${FILMS}/.plexignore.bak"
else
    echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : .plexignore file does not exist" >> $LOG
fi

for D in "${FILMS}/"*/
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
            find . -type f -name "*.avi" | cut -c 3- >> "${FILMS}/.plexignore" 2>&1
        else
            echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : A MKV version of this movie exists : No - .plexignore file not modified"  >> $LOG
        fi
    else
        echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : An AVI version of this movie exists : NO, adding the film name to alert log" >> $LOG
        echo "$(date "+%d.%m.%Y %H:%M:%S")" "---E--- : This movie does not have AVI version : ${D}" >> $NOAVI
    fi
done

cd "$FILMS" || exit

if [ -e "${FILMS}/.plexignore.bak" ]
then
    echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : DIFF between the previous plexignore and the current :" >> $LOG
    diff "${FILMS}/.plexignore.bak" "${FILMS}/.plexignore" >> $LOG
    rm "${FILMS}/.plexignore.bak"
fi

echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- :" >> $LOG

###################
# FILMS ANIMATION #
###################
cd "$FILMS_ANIMATION" || exit

echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : ROOT Folder :" "$(pwd)" >> $LOG

find . -type d -name "@eaDir" -exec rm -rf {} \;

if [ -e "${FILMS_ANIMATION}/.plexignore" ]
then
    echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : .plexignore file existing & deleted" >> $LOG
    mv "${FILMS_ANIMATION}/.plexignore" "${FILMS_ANIMATION}/.plexignore.bak"
else
    echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : .plexignore file does not exist" >> $LOG
fi

for D in "${FILMS_ANIMATION}/"*/
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
            find . -type f -name "*.avi" | cut -c 3- >> "${FILMS_ANIMATION}/.plexignore" 2>&1
        else
            echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : A MKV version of this movie exists : No - .plexignore file not modified"  >> $LOG
        fi
    else
        echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : An AVI version of this movie exists : NO, adding the film name to alert log" >> $LOG
        echo "$(date "+%d.%m.%Y %H:%M:%S")" "---E--- : This movie does not have AVI version : ${D}" >> $NOAVI
    fi
done

cd "$FILMS_ANIMATION" || exit

if [ -e "${FILMS_ANIMATION}/.plexignore.bak" ]
then
    echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : DIFF between the previous plexignore and the current :" >> $LOG
    diff "${FILMS_ANIMATION}/.plexignore.bak" "${FILMS_ANIMATION}/.plexignore" >> $LOG
    rm "${FILMS_ANIMATION}/.plexignore.bak"
fi

echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- :" >> $LOG

############################
# FILMS ANIMATION JAPONAIS #
############################
cd "$FILMS_ANIMATION_JP" || exit

echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : ROOT Folder :" "$(pwd)" >> $LOG

find . -type d -name "@eaDir" -exec rm -rf {} \;

if [ -e "${FILMS_ANIMATION_JP}/.plexignore" ]
then
    echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : .plexignore file existing & deleted" >> $LOG
    mv "${FILMS_ANIMATION_JP}/.plexignore" "${FILMS_ANIMATION_JP}/.plexignore.bak"
else
    echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : .plexignore file does not exist" >> $LOG
fi

for D in "${FILMS_ANIMATION_JP}/"*/
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
            find . -type f -name "*.avi" | cut -c 3- >> "${FILMS_ANIMATION_JP}/.plexignore" 2>&1
        else
            echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : A MKV version of this movie exists : No - .plexignore file not modified"  >> $LOG
        fi
    else
        echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : An AVI version of this movie exists : NO, adding the film name to alert log" >> $LOG
        echo "$(date "+%d.%m.%Y %H:%M:%S")" "---E--- : This movie does not have AVI version : ${D}" >> $NOAVI
    fi
done

cd "$FILMS_ANIMATION_JP" || exit

if [ -e "${FILMS_ANIMATION_JP}/.plexignore.bak" ]
then
    echo "$(date "+%d.%m.%Y %H:%M:%S")" "---I--- : DIFF between the previous plexignore and the current :" >> $LOG
    diff "${FILMS_ANIMATION_JP}/.plexignore.bak" "${FILMS_ANIMATION_JP}/.plexignore" >> $LOG
    rm "${FILMS_ANIMATION_JP}/.plexignore.bak"
fi

#_____END__________________________________________________________________________________________

echo "---------- END ----------" >> $LOG
echo "" >> $LOG
