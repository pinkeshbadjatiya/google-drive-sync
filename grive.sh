#! /bin/bash

	# Save the current location
	export LOCATION=$(pwd)

	# Make grive a function and add cp ~/.simple_starter ~/bin/...... 
	export LINE_LENGTH=50
	export DRIVE_MOUNT_PRESENT=0
	export LINKED_FILES_OK=0
	export CODES_DIR_PRESENT=0
	export INTERNET_WORKING=0
	export PROXY_REQUIRED=0
	export KEYBOARD_BACKUP_SCRIPT_PRESENT=0
	export LINK_DIR_PRESENT=0
	export STARTUP_FOLDER_PRESENT=0

	export Cross="$(tput setaf 1)\U2718$(tput sgr0)"
	export Tick="$(tput setaf 2)\U2714$(tput sgr0)"
	export Initial=" \U27A4"
	export Star="\UE219"


	# Generate Line
	boundary_line="\t"
	for i in $(seq "$LINE_LENGTH")
	do
		boundary_line=$(echo -n "$boundary_line$Star")
	done
	#boundary_line=$(echo -n "$boundary_line\n")


	if [ -d "/media/grim/44D8FB13D8FB024A" ]
	then
		DRIVE_MOUNT_PRESENT=1
		echo -n -e "$Initial Drive Mount\t\t\t\t$Tick\n"	
	else
		echo -n -e "$Initial Drive Mount\t\t\t\t$Cross\n"	
	fi

	if [ -d "/home/grim/codes/LINK" ]
	then
		LINK_DIR_PRESENT=1
		echo -n -e "$Initial LINK Directory\t\t\t$Tick\n"	
	else
		echo -n -e "$Initial LINK Directory\t\t\t$Cross\n"	
	fi

	if [ -d "/home/grim/.config/autostart" ]
	then
		STARTUP_FOLDER_PRESENT=1
		echo -n -e "$Initial StartUp Folder\t\t\t$Tick\n"	
	else
		echo -n -e "$Initial Startup FOlder\t\t\t$Cross\n"	
	fi



	if [ ! "$(find /home/grim/codes/LINK -xtype l)" ]
	then
		LINKED_FILES_OK=1
		echo -n -e "$Initial Soft links\t\t\t\t$Tick\n"
	else
		echo -n -e "$Initial Soft links\t\t\t\t$Cross\n"
	fi

	if [ -d "/home/grim/codes" ]
	then
		CODES_DIR_PRESENT=1
		echo -n -e "$Initial Codes Directory\t\t\t$Tick\n"	
	else
		echo -n -e "$Initial Codes Directory\t\t\t$Cross\n"	
	fi

	if [ -e "/home/grim/bin/keybindings/keybindings.pl" ]
	then
		KEYBOARD_BACKUP_SCRIPT_PRESENT=1
		echo -n -e "$Initial Keyboard Shortcuts Backup Script\t$Tick\n"	
	else
		echo -n -e "$Initial Keyboard Shortcuts Backup Script\t$Cross\n"	
	fi


	SET_PROXY 1

	if [[ $(check_internet) -eq 200 ||  $(check_internet) -eq 302 ]]
	then
		# Check with proxy
		export INTERNET_WORKING=1
		export PROXY_REQUIRED=1
		echo -n -e "$Initial Internet [Proxy]\t\t\t$Tick\n"	
	else
		UNSET_PROXY 1
		if [[ $(check_internet) -eq 200 ||  $(check_internet) -eq 302 ]]
		then
			# Check without proxy
			export INTERNET_WORKING=1
			export PROXY_REQUIRED=0
			echo -n -e "$Initial Internet [NoProxy]\t\t\t$Tick\n"	
		else
			echo -n -e "$Initial Internet\t\t\t\t$Cross\n"	
		fi
	fi


	if [[ $DRIVE_MOUNT_PRESENT -eq 1 && $LINK_DIR_PRESENT -eq 1 && $LINKED_FILES_OK -eq 1 && $CODES_DIR_PRESENT -eq 1 && $INTERNET_WORKING -eq 1 && $KEYBOARD_BACKUP_SCRIPT_PRESENT -eq 1 && $STARTUP_FOLDER_PRESENT -eq 1 ]]
	then
		echo -ne "\n"

		/home/grim/bin/keybindings/keybindings.pl -e /home/grim/bin/keybindings/key_bindings_backup.csv
		if [[ $? -ne 0 ]]
		then
			echo -ne "$(tput setaf 1)$boundary_line$(tput sgr0)"
			echo -ne "\n\t\tKeyboard Shortcuts Backup Utility Failure. Try Again :(\n"	
			echo -ne "$(tput setaf 1)$boundary_line$(tput sgr0)"
			echo -ne "\n\n"
			return 1
		fi

		ls -l /home/grim/codes/LINK > /home/grim/codes/LINK/link_list.txt
		if [[ $? -ne 0 ]]
		then
			echo -ne "$(tput setaf 1)$boundary_line$(tput sgr0)"
			echo -ne "\n\t\tSaving SOFT Links List Failure. Try Again :(\n"	
			echo -ne "$(tput setaf 1)$boundary_line$(tput sgr0)"
			echo -ne "\n\n"
			return 1
		fi


		if [ -d '~/bin/Startup_Applications_List' ]
		then
			rm -r ~/bin/Startup_Applications_List
		fi
		cp -r ~/.config/autostart ~/bin/Startup_Applications_List
		if [[ $? -ne 0 ]]
		then
			echo -ne "$(tput setaf 1)$boundary_line$(tput sgr0)"
			echo -ne "\n\t\tSaving Startup Applications List Failure. Try Again :(\n"	
			echo -ne "$(tput setaf 1)$boundary_line$(tput sgr0)"
			echo -ne "\n\n"
			return 1
		fi


		cd ~/codes
		#mv ~/Applications/BitTorrent-Sync_x64/.sync ~/GRIVE_SSYNC	# Move Temporarily
		#(trap clean_up SIGINT; /usr/bin/grive; mv ~/GRIVE_SSYNC ~/Applications/BitTorrent-Sync_x64/.sync)	# Catch SIGINT + Sync + Restore AND Make it a single process
		/usr/bin/grive
		OUT=$?
		if [[ $OUT -ne 0 ]]
		then
			echo -ne "$(tput setaf 1)$boundary_line$(tput sgr0)"
			echo -ne "\n\t\tIntrupting grive is not recommended. Check back later. :(\n"	
			echo -ne "$(tput setaf 1)$boundary_line$(tput sgr0)"
			echo -ne "\n\n"
			cd $LOCATION
			return 1
		fi
		echo -ne "$(tput setaf 2)$boundary_line$(tput sgr0)"
		echo -ne "\n\t\tSeems, everything went as expected. Synchronised. :)\n"	
		echo -ne "$(tput setaf 2)$boundary_line$(tput sgr0)"
		echo -ne "\n\n"
		cd $LOCATION
		return 0
	else
		echo -ne "$(tput setaf 1)$boundary_line$(tput sgr0)"
		echo -ne "\n\t\tYou have some things to worry about :(\n"	
		echo -ne "$(tput setaf 1)$boundary_line$(tput sgr0)"
		echo -ne "\n\n"
		cd $LOCATION
		return 1
	fi
