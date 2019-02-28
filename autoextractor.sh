#!/bin/bash
#########################################################
# reuqires p7zip - apt-get install p7zip-full p7zip-rar #
#########################################################

# print "{progname} - {all args}"
function my_print(){
	echo $0 - $* 
	my_log $*
}

# log to logfile
function my_log(){
	echo $(date) $0 - $* >> "$DIR"/log
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" #get script dir
if [ ! -f "$DIR"/config ]; then
	my_print "No config file found. You can copy 'config.default' to 'config' and set options there. Beware that archive selection is inside this script and not (yet) in the config file"
	exit 1
fi
source "$DIR"/config #get config

if [ ! -f "$ALREADYEXTRACTED" ]; then
	touch "$ALREADYEXTRACTED"
fi

cd $FOLDER #go to folder

while (( 1 )); do
	for filename in "$FOLDER"/*.{zip,rar,tar} ; do #loop through watched - couldnt figure out how to move this brace expansion to a variable
		[ -e "$filename" ] || continue #make sure its a valid file - when no match for an extension its still put in as "*.ext" - skip those
		if grep -Fxq "$filename" "$ALREADYEXTRACTED"; then
			my_log "Skipping already extracted item: $filename"
			continue
		fi
	    if 7z t "$filename" >/dev/null; then #check if possible to extract file
	        if 7z x "$filename" -y -o* >/dev/null; then # extract it, -o* = output to archive_name as folder
	            my_print 'Extracted' $filename 'successfully'
	        	echo "$filename" >> $ALREADYEXTRACTED #add to already extracted list
	        else #extraction failed
	            my_print 'Failed to extract' $filename
	        fi
	    else
	        my_print '7z could not recognize this file' $filename  #file cant be extracted
	    fi
	done
#	sleep 5
	source "$DIR"/config #get config
	my_print $(inotifywait -e modify -e moved_to -e create $FOLDER) #wait for updates to watched folder

done

