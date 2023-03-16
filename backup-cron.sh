#!/bin/bash


dir=$1
backupdir=$2
max_backups=$3

if [ ! $# -eq 3 ]; then echo "Invalid number of arguments. Please provide 3 only!"; exit 1; fi
if [ ! -d $dir ]; then echo "The directory you're trying to backup doesn't exist!"; exit 1; fi
if [ ! -d $backupdir ]; then mkdir $backupdir ; fi
if ! [[ $max_backups =~ ^[0-9]+$ ]]; then echo "Please enter a valid number of max backups!" ; exit 1; fi 
if [ ! -f directory-info.last ]
then
	touch directory-info.last
fi

ls -lR $dir>directory-info.new
backup_count=$(ls -l $backupdir | grep ^d | wc -l)

cmp -s directory-info.last directory-info.new
if [ $? -eq 1 ]
then
	while [ $backup_count -ge $max_backups ]
	do
                oldest_dir=$(find $backupdir/ -type d -printf '%T+ %p\n' | sort | head -n 1 | cut -d' ' -f2)
                rm -r $oldest_dir
                backup_count=`expr $backup_count - 1`
        done
	cp -r $dir $backupdir/`date +%Y-%m-%d-%H-%M-%S`
        echo "$dir backup successful!"
	cat directory-info.new>directory-info.last
        backup_count=`expr $backup_count + 1`
fi

