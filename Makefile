# srcdir=~/6926-lab2/src
# backupdir=~/6926-lab2/dest
srcdir=src
backupdir=dest
interval=2
max_backups=2

all: prebuild build

build: prebuild
	@chmod +x backupd.sh
	@./backupd.sh $(srcdir) $(backupdir) $(interval) $(max_backups)
prebuild:
	@if  [ ! -d $(backupdir) ]; then mkdir $(backupdir); fi



