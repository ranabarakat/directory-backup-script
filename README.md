
# Directory Backup Script

This project is dedicated to backup a directory to another directory every fixed amount of time should there be any modification.
The backup directory will contain several directories with the date and time of their creation. 
The number of directories inside it will depend on the maximum allowable backups. This is currently set to 4, but it can be modified as shown in the instructions section.
The folder contains the backup script (backupd.sh), and the Makefile.
You will run the backup using Makefile as illustrated below.



## Prerequisites

Before running the backup script, you need to ensure that you have the Make package installed. 
The make command is used to execute the Makefile which is a unique file that includes the shell commands we write to keep the project running. 

The following command verifies that make is already installed, as it should come with ubuntu OS by default.
```bash
make --version
```
If you get an error such as "There is no such file or directory," you can install the package using the following command
```bash
sudo apt install make
```
 
## Extracting tar.gz files in linux
A tar.gz file is a combination of .tar and .gz files. A tar file is an archive which contains multiple files combined. A .gz file provides the compressed version of that file.

You can unzip the tar.gz file using the following command
```bash
tar –xvzf 6926-lab2.tar.gz –C /home/user/destination
```
where /home/user/destination is the destination of the extracted files. You can also leave it out and the files will be extracted in the current working directory.
```bash
tar –xvzf 6926-lab2.tar.gz
```

## Instructions

You will find a Makefile inside the folder. This is where you will specify the directory you wish to backup, and update your preferences.
```bash
  srcdir=~/6926-lab2/src
  backupdir=~/6926-lab2/dest
  interval=2
  max_backups=4
```
To start backing up your desired directory:

1. Modify {srcdir} by providing the full path to the directory you want to back up.
2. Modify {backupdir} by providing the full path to the directory that will contain all backups.


`Note: If the provided backup directory is not created, Makefile will create it for you.`

`Note: If you leave {backupdir} unchanged, all backups will be created in a {dest} directory in the project folder.` 

3. Modify {interval} to the desired interval between every check in seconds.
4. Finally, Modify {max_backups} to limit the number of saved backups. Only the {max_backups} recent directories will be kept.
