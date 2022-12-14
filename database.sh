<<doc
Name : Utsava Kumar Singh
Date : 19-08-2022
Description : A simple shell script which is capable of manipulating address database. Using this script user should able to 
              store the information, view the information and to edit the information.
doc

#!/bin/bash

# The file names
database_file=database.csv					#database.csv file contains all the user information 
database_log_file=database.log			  		#database.log file contains all the activities with timestamp

# The global variables
name=
email=
tel_no=
mob_no=								#clearing all the global variables
place=
message=

# Colour codes for 'tput' command
red=1
green=2
yellow=3
blue=4
cyan=6

# Time out periods
menu_time_out=10						#time to log out if user does not given any response
long_delay=5							#long delay time to show the message
short_delay=3							#short delay time to show the message


#=================================================== page_title function definition ====================================================================

function page_title()
{
    # This function is for printing the page title
    
    clear
    echo "          --------------------------"
    # $(tput setaf $yellow) - select the text colour, $(tput setab $blue) - select the background colour, $(tput bold) - select the bold mode, 
    # $(tput sgr 0) - resetting to default
    echo "         |$(tput setaf $yellow)$(tput setab $blue)$(tput bold)     DATABASE PROJECT     $(tput sgr 0)|"       
    echo -e "          --------------------------\n"
}

#==================================================== variable_clear function definition ===============================================================

function variable_clear()
{
    # This function is for clearing all the data stored in these global variables

    name=
    email=
    tel_no=							#clear all global variables
    mob_no=
    place=
    message=
}

#======================================================= log function definition =======================================================================

function log()
{
    # This function is for writing activities to log file along with timestamp, passing argument as a string

    date_time=`date +'%d-%m-%Y %H:%M:%S'`			#storing current date and time in date_time variable for timestamp
    echo "$date_time - $1" >> "$database_log_file"		#storing user activities to database_log_file
}

#==================================================== menu_header function definition ==================================================================

function menu_header()
{
    # This function is for printing welcome menu presntation

    #calling page_title function
    page_title	
    echo -e "     $(tput setab $red)$(tput bold)            Home Screen             $(tput sgr 0)\n" 						 
    echo -e "\n  $(tput setaf $blue)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
    echo "  1. Add Entry"
    echo "  2. Search / Edit Entry"
    echo -e "  $(tput setaf $red)x.$(tput sgr 0) Exit\n"
    echo -e "  $(tput setaf $red)$(tput bold)Note:$(tput sgr 0) Script Exit Timeout is set\n"
}

#===================================================== field_menu function definition ==================================================================

save_menu_flag=0						#this flag is for printing save option to choose for the user  
function field_menu()
{
    # This fuction for printing a selected user information 
    # Name, Email, Tel no, Mob num, Address, Message

    echo "  1. Name       : "$name""
    echo "  2. Email      : "$email""
    echo "  3. Tel No     : "$tel_no""
    echo "  4. Mob No     : "$mob_no""
    echo "  5. Place      : "$place""
    echo "  6. Message    : "$message""
    if [ $save_menu_flag -eq 1 ]
    then
        echo "  $(tput setaf $green)7. Save$(tput sgr 0)"
    fi
    save_menu_flag=0
    echo -e "  $(tput setaf $red)x.$(tput sgr 0) Exit\n"
}

#====================================================== array_search function definition ===============================================================

function array_search()
{
    # This function is for searching the reqired row in the database_file according to the information given by the user

    #At first cat command with is the use piping send the output to cut command which take out the required column from the input and send it to 
    #grep command through the use of piping which search the particular data given by the user irrespective of case and give line nubers were data
    #is present by the use of cut command and save it as an array in position_array
    position_array=( `cat "$database_file" | cut -d "," -f"$1" | grep -i -n -x "$2" | cut -d ":" -f1` )
    
    #checking the searched data is present or not
    if [ ${#position_array[*]} -gt 0 ]
    then
        #if present than checking more than one times it is present or not
	if [ ${#position_array[*]} -gt 1 ] 
        then
    	    echo
	    #If data is present more than one times then logic to print each matched data on the screen and asking user to choose which data 
	    #he/she wants to edit
    	    for i in `seq 0 1 $(("${#position_array[*]}"-1))`
            do
               	found_array=( `sed -n "${position_array[i]}"p "$database_file"` )
       		echo "[$((i+1))] ${found_array[*]}"
    	    done
	    user_error_flag=0						#this flag is for coming out of the while loop (for taking input)
    	    while [ $user_error_flag -eq 0 ]
    	    do
    	         echo -e -n "\n  Select the user number to be displayed: "
    	         read user_choice
    	         len_found_array=${#position_array[*]}
		 #logic to check that the user chosen the correct option
    	         if [ "$user_choice" -gt 0 -a "$user_choice" -le "$len_found_array" ]
    	         then
    	             data_position="${position_array[$((user_choice-1))]}"
    	             user_error_flag=1
    	         else
    	         echo -e "\n  $(tput setaf $red)You have selected wrong option.$(tput sgr 0) Please try again"
    	         user_error_flag=0
    	         fi
    	     done    	    
    	else
            data_position="${position_array[0]}"
        fi
        #calling found_data_store function
        found_data_store 
    else
    	 echo "  $(tput setaf $red)Entered "$3" is not found in the database$(tput sgr 0)"
    	 #calling variable_clear function
    	 variable_clear
    	 search_exit_flag=1
         sleep $short_delay
     fi
}

#====================================================== found_data_store function definition ===========================================================

function found_data_store()
{
    # This function is for storing the data found by the data_search function in the global variables
    
    found_array=( `sed -n "$data_position"p "$database_file"` )
    name=`echo "${found_array[*]}" | cut -d "," -f3`
    email=`echo "${found_array[*]}" | cut -d "," -f4`
    tel_no=`echo "${found_array[*]}" | cut -d "," -f5`
    mob_no=`echo "${found_array[*]}" | cut -d "," -f6`
    place=`echo "${found_array[*]}" | cut -d "," -f7`
    message=`echo "${found_array[*]}" | cut -d "," -f8`
    #calling log function
    log "$name has searched his database"
}

#========================================================= edit_operation function definition ==========================================================

function edit_operation()
{
    # This function provides an option to change fields of an entry
    # 1. Ask the  user about the field to edit
    # 2. As per user selection, prompts a message to enter respected value
    # 3. Verify the user entry to field for matching. Eg mob number only 10 digits to enter
    # 4. Prompts error in case any mismatch of entered data and fields

    while [ $edit_exit_flag -eq 0 ]
    do
        #calling page_title function
        page_title	
        echo -e "     $(tput setab $red)$(tput bold)       Search / Edit Screen         $(tput sgr 0)\n"  	
        echo -e "\n  $(tput setaf $blue)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
        echo -e "\n  Search / $(tput setaf $red)$(tput bold)Edit$(tput sgr 0) by:\n"
        save_menu_flag=1					#set the flag to show save option also on the Search/Edit screen
        #calling field_menu function
        field_menu
        save_menu_flag=0
        read -p "  Please choose your option: " option
        page_title	
        echo -e "     $(tput setab $red)$(tput bold)       Search / Edit Screen         $(tput sgr 0)\n"    	
        echo -e "\n  $(tput setaf $blue)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
        echo -e "\n  Search / $(tput setaf $red)$(tput bold)Edit$(tput sgr 0) by:\n"
        save_menu_flag=1
        #calling field_menu function
        field_menu
        save_menu_flag=0
                
        case $option in
            1) #for name input
	       name_flag=0					#flag for checking the user input has passed all validation
               name_error_flag=0				#flag for showing the error message
               while [ $name_flag -eq 0 ]
               do
                     if [ $name_error_flag -eq 1 ]
                     then
                         echo -e "  $(tput setaf $red)\nPlease enter a name which contains only alphabets, spaces and atlest of 3 character\n  $(tput sgr 0)Try again to enter a valid name\n"
                     fi
            	     read -p "  Please enter the new Name: " name
		     #calling validate_entry function
                     validate_entry $option
               done
               ;;
            2) #for mail input
	       mail_flag=0
               mail_error_flag=0
               while [ $mail_flag -eq 0 ]
               do
                    if [ $mail_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf $red)\n  Please enter a valid E-mail ID\n  $(tput sgr 0)Try again to enter a valid E-mail ID\n"
                    fi    
                    read -p "  Please enter the new Email: " email
		    #calling validate_entry function
                    validate_entry $option
               done
               ;;
            3) #for telephone number input
	       tel_flag=0
               tel_error_flag=0
               while [ $tel_flag -eq 0 ]
               do
                    if [ $tel_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf $red)\n  Please enter a valid Telephone Number\n  $(tput sgr 0)Try again to enter a valid Telephone Number\n"
                    fi    
                    read -p "  Please enter the new Telephone Number: " tel_no
                    #calling validate_entry function
		    validate_entry $option
               done
               ;;
            4) #for mobile number input
	       mob_flag=0
               mob_error_flag=0
               while [ $mob_flag -eq 0 ]
               do
                    if [ $mob_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf $red)\n  Please enter a valid Mobile Number\n  $(tput sgr 0)Try again to enter a valid Mobile Number\n"
                    fi    
                    read -p "  Please enter the new Mobile Number: " mob_no
		    #calling validate_entry functon
                    validate_entry $option
               done            
               ;;
            5) #for place input
	       place_flag=0
               place_error_flag=0
               while [ $place_flag -eq 0 ]
               do
                     if [ $place_error_flag -eq 1 ]
                     then
                         echo -e "$(tput setaf $red)\n  Please enter a Place which contains only alphabets, spaces and atlest of 3 character\n$(tput sgr 0)  Try again to enter a valid Place\n"
                     fi
            	     read -p "  Please enter the new Place: " place
		     #calling validate_entry function
                     validate_entry $option 
               done            
               ;;
            6) #for message input
	       read -p "  Please enter the new Message: " message
               ;;
            7) #for updating the data
	       date_time=`date +'%d-%m-%Y,%H:%M:%S'`
	       #updating a row in the database_file by the use of sed command
               sed -i "$data_position"s/.*/"$date_time,$name,$email,$tel_no,$mob_no,$place,$message"/ "$database_file"
	       #calling log function
               log "Updated $name data in the database.csv file"
	       #calling variable_clear function
    	       variable_clear
               #calling search_and_edit function
               search_and_edit
               ;;
            x) #to exit the search screen
	       edit_exit_flag=1
	       #calling log function
               log "Exited edit / search menu"
               ;;
            *) echo "  $(tput setaf $red)Please coose the correct option!$(tput sgr 0)"
	       sleep $short_delay					#delay
          esac
    done	
}

#========================================================== search_operation function definition =======================================================

function search_operation()
{
	# This function asks user for a value to search
	# 1. Value can be from any field of an entry.
	# 2. One by one iterates through each line of database file and search for the entry
	# 3. If available display all fields for that entry
	# 4. Prompt error incase not available
	
         search_exit_flag=0						#flag to exit from the search/edit screen
	 #calling variable_clear function
         variable_clear
	 #calling page_title function
         page_title	
         echo -e "     $(tput setab $red)$(tput bold)       Search / Edit Screen         $(tput sgr 0)\n"  	
         echo -e "\n  $(tput setaf $blue)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
         echo -e "\n  $(tput setaf $red)$(tput bold)Search$(tput sgr 0) / Edit by:\n"
         #calling field_menu function
         field_menu
         case $choice in
            1) read -p "  Please enter the Name: " name
               #calling array_search function
               array_search 3 "$name" name
               ;;
            2) read -p "  Please enter the Email: " email
               #calling array_search function
               array_search 4 "$email" E-mail
               ;;
            3) read -p "  Please enter the Telephone Number: " tel_no
               #calling array_search function
               array_search 5 "$tel_no" "Telephone Number"
               ;;
            4) read -p "  Please enter the Mobile Number: " mob_no
               mob_no="+91-$mob_no"
               #calling array_search function
               array_search 6 "$mob_no" "Mobile Number"
               ;;
            5) read -p "  Please enter the Place: " place
               #calling array_search function
               array_search 7 "$place" Place
               ;;
            6) read -p "  Please enter the Message: " message
               #calling array_search function
               array_search 8 "$message" message
               ;;
            x) edit_exit_flag=1
               ;;
            *) echo "  $(tput setaf $red)Please coose the correct option!$(tput sgr 0)"
	       sleep $short_delay					#delay
          esac
}

#====================================================== search_and_edit function definition ============================================================

function search_and_edit()
{
    # This fuction prints the  UI for editing and searching 
    # 1. Shows realtime changes while editing
    # 2. Calls above functions respectively

    edit_exit_flag=0							#initializing the edit_exit_flag to continue the while loop
    while [ $edit_exit_flag -eq 0 ]
    do
         #calling page_title function
         page_title	
         echo -e "     $(tput setab $red)$(tput bold)       Search / Edit Screen         $(tput sgr 0)\n" 	
         echo -e "\n  $(tput setaf $blue)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
         echo -e "\n  $(tput setaf $red)$(tput bold)Search$(tput sgr 0) / Edit by:\n"
         #calling field_menu function
         field_menu
         read -p "  Please choose the field to be searched: " choice
         #calling search_operation function
         search_operation
         if [ "$search_exit_flag" -eq 0 ]
         then
             #calling edit_operation function
             edit_operation
         fi
     done
}

#============================================================ database_entry function definition ========================================================

function database_entry()
{
	# This function writes user inputs to database file
	# 1. If some fields are missing adds consicutive ','. Eg: user,,,,,

	#checking database_file is present or not
	if [ ! -f $database_file ]
	then
	    #If not than create it
	    touch "$database_file"
	    working_dir=`pwd`
	    #calling log function
	    log "Created database.csv file at $working_dir"
	fi
	date_time=`date +'%d-%m-%Y,%H:%M:%S'`
	echo "$date_time,$name,$email,$tel_no,$mob_no,$place,$message" >> "$database_file"
	#calling log function
	log "New user ($name) data is added in database.csv file"
}

#=========================================================== validate_entry function definition ========================================================

function validate_entry()
{
	# This function validates inputs entered by user as per fields
	# 1. Names should have only alphabets
	# 2. Emails must have a @ symbols and ending with .<domain> Eg: user@mail.com
	# 3. Mobile/Tel numbers must have 10 digits .
	# 4. Place must have only alphabets

	case $1 in
            1) # Name validation
               len_user=${#name}
	       #checking that name only contains alphabets and space should be at least of 3 characters
               if [[ "$name" =~ ^[a-z' 'A-Z]+$ && "$len_user" -ge 3 ]]
	       then
		   #converting name variable string into sentence case
		   name=`echo "$name" | tr '[A-Z]' '[a-z]' | sed -E "s/[[:alpha:]]+/\u&/g"`
		   name_flag=1
		   name_error_flag=0    
	       else
		   name_error_flag=1
		   name_flag=0
	       fi
               ;;
            2) # Email validation
               if [[ "$email" =~ ^[a-zA-Z0-9._@]+$ && "$email" =~ [@] && "$email" =~ [.] ]]
		then
		    mail_flag=1
                    mail_error_flag=0 
		else
		    mail_flag=0
                    mail_error_flag=1
		fi     
               ;;
            3) # Telephone Number validation
               if [[ "$tel_no" =~ ^[0-9]+$ ]]
		then
		    tel_flag=1
                    tel_error_flag=0 
		else
		    tel_flag=0
                    tel_error_flag=1
		fi     
               ;;
            4) # Mobile Number validation
               len_mob=${#mob_no}
               if [[ "$mob_no" =~ ^[0-9]+$ && "$len_mob" -eq 10 ]]
	       then
		   mob_no="+91-$mob_no"
		   mob_flag=1
		   mob_error_flag=0    
	       else
		   mob_error_flag=1
		   mob_flag=0
	       fi
               ;;
            5) # Place validation
               len_place=${#place}
               if [[ "$place" =~ ^[a-z' 'A-Z]+$ && "$len_place" -ge 3 ]]
	       then
		   place=`echo "$place" | tr '[A-Z]' '[a-z]' | sed -E "s/[[:alpha:]]+/\u&/g"`
		   place_flag=1
		   place_error_flag=0    
	       else
		   place_error_flag=1
		   place_flag=0
	       fi
               ;;
          esac
}

#========================================================== add_entry function definition ==============================================================

function add_entry()
{
    # This function adds a new entry to database
    # 1. Validates the entries
    # 2. Add to database
    add_exit_flag=0							#initializing the add_exit_flag to continue the while loop
    while [ $add_exit_flag -eq 0 ]
    do
         #calling page_title function
         page_title	
         echo -e "     $(tput setab $red)$(tput bold)       Add New Entry Screen         $(tput sgr 0)\n" 	
         echo -e "\n  $(tput setaf $blue)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
         #calling field_menu function
         field_menu
         read -p "  Please choose the field to be added: " choice
         #calling page_title function
         page_title	
         echo -e "     $(tput setab $red)$(tput bold)       Add New Entry Screen         $(tput sgr 0)\n" 	
         echo -e "\n  $(tput setaf $blue)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
         #calling field_menu function
         field_menu
         case $choice in
            1) name_flag=0
               name_error_flag=0
               while [ $name_flag -eq 0 ]
               do
                     if [ $name_error_flag -eq 1 ]
                     then
                         echo -e "$(tput setaf $red)\n  Please enter a name which contains only alphabets, spaces and atlest of 3 character\n  $(tput sgr 0)Try again to enter a valid name\n"
                     fi
            	     read -p "  Please enter the Name: " name
                     #calling validate_entry function
                     validate_entry $choice
               done
               ;;
            2) mail_flag=0
               mail_error_flag=0
               while [ $mail_flag -eq 0 ]
               do
                    if [ $mail_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf $red)\n  Please enter a valid E-mail ID\n$(tput sgr 0)  Try again to enter a valid E-mail ID\n"
                    fi    
                    read -p "  Please enter the Email: " email
		    #calling validate_entry function
                    validate_entry $choice
               done
               ;;
            3) tel_flag=0
               tel_error_flag=0
               while [ $tel_flag -eq 0 ]
               do
                    if [ $tel_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf $red)\n  Please enter a valid Telephone Number\n  $(tput sgr 0)Try again to enter a valid Telephone Number\n"
                    fi    
                    read -p "  Please enter the Telephone Number: " tel_no
		    #calling validate_entry function
                    validate_entry $choice
               done
               ;;
            4) mob_flag=0
               mob_error_flag=0
               while [ $mob_flag -eq 0 ]
               do
                    if [ $mob_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf $red)\n  Please enter a valid Mobile Number\n$(tput sgr 0)  Try again to enter a valid Mobile Number\n"
                    fi    
                    read -p "  Please enter the Mobile Number: " mob_no
		    #calling validate_entry function
                    validate_entry $choice
               done            
               ;;
            5) place_flag=0
               place_error_flag=0
               while [ $place_flag -eq 0 ]
               do
                     if [ $place_error_flag -eq 1 ]
                     then
                         echo -e "$(tput setaf $red)\n  Please enter a Place which contains only alphabets, spaces and atlest of 3 character\n$(tput sgr 0)  Try again to enter a valid Place\n"
                     fi
            	     read -p "  Please enter the Place: " place
                     #calling validate_entry function  
                     validate_entry $choice 
               done            
               ;;
            6) read -p "  Please enter the Message: " message
               ;;
            x) #calling database_entry function
               database_entry
               add_exit_flag=1
               ;;
            *) echo "  $(tput setaf $red)Please coose the correct option!$(tput sgr 0)"
	       sleep $short_delay				#delay
          esac
     done
}

#============================================================= main script ==============================================================================

exit_flag=0							#initializing the exit_flag to continue the while loop
#calling log function
log "Script invoked"						
while [ $exit_flag -eq 0 ]
do
    #calling variable_clear function
    variable_clear
    #calling menu_header function
    menu_header

    #logic for time-out
    for j in `seq "$menu_time_out" -1 1`
    do
        echo -n -e "\r  Please choose your option: \c"
	read -t 1 choice					#taking user choice as single character 
	 #if no character is passed as input than save default value '+' in 'choice' variable
	 if [ -n "$choice" ]				
	 then
	     break						#come out of if condition block if user entered any input
         else
	      choice=+
	 fi
    done
        
    case $choice in	
            1) add_entry 					#calling add_entry function if user choose option 1
	       ;;
    	    2) search_and_edit					#calling search_and_edit function if user choose option 2
	       ;;
    	    x) exit_flag=1					#setting exit_flag to come out of the while loop if user choose option 3
    	       #calling log function
	       log "Script exited"
    	       ;;
    	    +) #If user has not entered any value in set time out period then this option will execute
    	       echo -e "$(tput setaf $red)\n\n  Time out occured as you have not chosen any option$(tput sgr 0)\n"
    	       exit_flag=1					#setting exit_flag to come out of the while loop if user has not given any input
    	       #calling log function
	       log "Script timed out!!"
    	       ;;
	    *)  #defualt condition if the user entered some other value
	       echo -e "\n  $(tput setaf $red)Please choose the correct option!$(tput sgr 0)"
	       sleep $short_delay						#delay
    	       ;;
     esac
done 

#**************************************************************** End of Script ************************************************************************
