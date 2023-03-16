#!/bin/bash


dir=$1 #src directory
backupdir=$2  #dest directory
interval=$3 #time between backups
max_backups=$4 #max backups in dest

if [ ! $# -eq 4 ]; then echo "Invalid number of arguments. Please provide 4 only!"; exit 1; fi
if [ ! -d $dir ]; then echo "The directory you're trying to backup doesn't exist!"; exit 1; fi
if ! [[ $max_backups =~ ^[0-9]+$ ]]; then echo "Please enter a valid number of max backups!" ; exit 1; fi 
if ! [[ $interval =~ ^[0-9]+$ ]]; then echo "Please enter a valid interval in seconds!" ; exit 1; fi 
	
ls -lR $dir>directory-info.last
cp -r $dir $backupdir/`date +%Y-%m-%d-%H-%M-%S`
echo "$dir backup successful!"

#counts the number of backups in backupdir
#ls -l lists the subdirectories
# grep finds directories prefixed with d,
#wc -l counts the number of lines to count subdirectories
backup_count=$(ls -l $backupdir | grep ^d | wc -l)

while true
do
	if [ ! -d $dir ]; then echo "The directory you're trying to backup doesn't exist!"; exit 1; fi 
	sleep $interval
	ls -lR $dir>directory-info.new
	cmp -s directory-info.last directory-info.new
	#exit status of cmp = 1 when files are not identical
	#$? gets the exit status of the last executed command
	if [ $? -eq 1 ]
	then
		while [ $backup_count -ge $max_backups ]
		do
			#find subdirectories in backupdir & print modification date & path,
			#sort to find first entry(oldest),
			#get only the path by cutting out the date & time
			oldest_dir=$(find $backupdir/ -type d -printf '%T+ %p\n' | sort | head -n 1 | cut -d' ' -f2)
                        rm -r $oldest_dir
			backup_count=`expr $backup_count - 1`
		done
		cp -r $dir $backupdir/`date +%Y-%m-%d-%H-%M-%S`
		cat directory-info.new>directory-info.last
		echo "$dir backup successful!"
		backup_count=`expr $backup_count + 1`
	fi
done
