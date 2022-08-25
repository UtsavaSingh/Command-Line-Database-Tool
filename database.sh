<<doc
Name : Utsava Kumar Singh
Date : 19-08-2022
Description : A simple shell script which is capable of manipulating address database. Using this script user should able to 
              store the information, view the information and to edit the information.
doc

#!/bin/bash

database_file=database.csv
short_delay=3

#================================= page_title function definition ================================

function page_title()
{
    clear
    echo "   =========================="
    # $(tput setaf 1) - select the text colour, $(tput setab 3) - select the background colour, $(tput bold) - select the bold mode, 
    # $(tput sgr 0) - resetting to default
    echo "  |$(tput setaf 1)$(tput setab 3)$(tput bold)     Database Project     $(tput sgr 0)|"       
    echo -e "   ==========================\n"
}

#================================ variable_clear function definition =============================

function variable_clear()
{
    name=
    email=
    tel_no=
    mob_no=
    place=
    message=
}

#================================== log function definition ======================================

function log()
{
	echo "function"
	#TODO Write activities to log files along with timestamp, pass argument as a string
}

#=============================== menu_header function definition =================================

function menu_header()
{
    # TODO Just to print welcome menu presntation
    #calling page_title function
    page_title												
    echo -e "\n$(tput setaf 4)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
    echo "1. Add Entry"
    echo "2. Search / Edit Entry"
    echo -e "$(tput setaf 1)x.$(tput sgr 0) Exit\n"
}

#=============================== field_menu function definition ==================================

save_menu_flag=0
function field_menu()
{
    # TODO to print a selected user information 
    # Name, Email, Tel no, Mob num, Address, Message
    echo "1. Name       : "$name""
    echo "2. Email      : "$email""
    echo "3. Tel No     : "$tel_no""
    echo "4. Mob No     : "$mob_no""
    echo "5. Place      : "$place""
    echo "6. Message    : "$message""
    if [ $save_menu_flag -eq 1 ]
    then
        echo "$(tput setaf 2)7. Save$(tput sgr 0)"
    fi
    echo -e "$(tput setaf 1)x.$(tput sgr 0) Exit\n"
}

#============================== array_search function definition ================================

function array_search()
{
    position_array=( `cat "$database_file" | cut -d "," -f"$1" | grep -i -n -x "$2" | cut -d ":" -f1` )
    if [ ${#position_array[*]} -gt 0 ]
    then
        if [ ${#position_array[*]} -gt 1 ] 
        then
    	    echo
    	    for i in `seq 0 1 $(("${#position_array[*]}"-1))`
            do
               found_array=( `sed -n "${position_array[i]}"p "$database_file"` )
       	echo "[$((i+1))] ${found_array[*]}"
    	    done
    	    user_error_flag=0
    	    while [ $user_error_flag -eq 0 ]
    	    do
    	         echo -e -n "\nSelect the user number to be displayed: "
    	         read user_choice
    	         len_found_array=${#position_array[*]}
    	         if [ "$user_choice" -gt 0 -a "$user_choice" -le "$len_found_array" ]
    	         then
    	             data_position="${position_array[$((user_choice-1))]}"
    	             user_error_flag=1
    	         else
    	         echo -e "\n$(tput setaf 1)You have selected wrong option.$(tput sgr 0) Please try again"
    	         user_error_flag=0
    	         fi
    	     done    	    
    	else
            data_position="${position_array[0]}"
        fi
        #calling found_data_store function
        found_data_store 
    else
    	 echo "$(tput setaf 1)Entered "$3" is not found in the database$(tput sgr 0)"
    	 #calling variable_clear function
    	 variable_clear
    	 search_exit_flag=1
         sleep $short_delay
     fi
}

#============================== found_data_store function definition ================================

function found_data_store()
{
    found_array=( `sed -n "$data_position"p "$database_file"` )
    name=`echo "${found_array[*]}" | cut -d "," -f3`
    email=`echo "${found_array[*]}" | cut -d "," -f4`
    tel_no=`echo "${found_array[*]}" | cut -d "," -f5`
    mob_no=`echo "${found_array[*]}" | cut -d "," -f6`
    place=`echo "${found_array[*]}" | cut -d "," -f7`
    message=`echo "${found_array[*]}" | cut -d "," -f8`
}

#============================== edit_operation function definition ================================

function edit_operation()
{
    # TODO Provide an option to change fields of an entry
    # 1. Ask user about the field to edit
    # 2. As per user selection, prompt a message to enter respected value
    # 3. Verify the user entry to field for matching. Eg mob number only 10 digits to enter
    # 4. Prompt error in case any mismatch of entered data and fields
    while [ $edit_exit_flag -eq 0 ]
    do
        #calling page_title function
        page_title	
        echo -e "$(tput setab 6)$(tput bold)     Search / Edit Screen       $(tput sgr 0)\n"  	
        echo -e "\n$(tput setaf 4)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
        echo -e "\nSearch / $(tput setaf 1)$(tput bold)Edit$(tput sgr 0) by:\n"
        save_menu_flag=1
        #calling field_menu function
        field_menu
        save_menu_flag=0
        read -p "Please choose your option: " option
        page_title	
        echo -e "$(tput setab 6)$(tput bold)     Search / Edit Screen       $(tput sgr 0)\n"  	
        echo -e "\n$(tput setaf 4)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
        echo -e "\nSearch / $(tput setaf 1)$(tput bold)Edit$(tput sgr 0) by:\n"
        save_menu_flag=1
        #calling field_menu function
        field_menu
        save_menu_flag=0
                
        case $option in
            1) name_flag=0
               name_error_flag=0
               while [ $name_flag -eq 0 ]
               do
                     if [ $name_error_flag -eq 1 ]
                     then
                         echo -e "$(tput setaf 1)\nPlease enter a name which contains only alphabets, spaces and atlest of 3 character\n$(tput sgr 0)Try again to enter a valid name\n"
                     fi
            	     read -p "Please enter the new Name: " name
                    validate_entry $option
               done
               ;;
            2) mail_flag=0
               mail_error_flag=0
               while [ $mail_flag -eq 0 ]
               do
                    if [ $mail_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf 1)\nPlease enter a valid E-mail ID\n$(tput sgr 0)Try again to enter a valid E-mail ID\n"
                    fi    
                    read -p "Please enter the new Email: " email
                    validate_entry $option
               done
               ;;
            3) tel_flag=0
               tel_error_flag=0
               while [ $tel_flag -eq 0 ]
               do
                    if [ $tel_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf 1)\nPlease enter a valid Telephone Number\n$(tput sgr 0)Try again to enter a valid Telephone Number\n"
                    fi    
                    read -p "Please enter the new Telephone Number: " tel_no
                    validate_entry $option
               done
               ;;
            4) mob_flag=0
               mob_error_flag=0
               while [ $mob_flag -eq 0 ]
               do
                    if [ $mob_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf 1)\nPlease enter a valid Mobile Number\n$(tput sgr 0)Try again to enter a valid Mobile Number\n"
                    fi    
                    read -p "Please enter the new Mobile Number: " mob_no
                    validate_entry $option
               done            
               ;;
            5) place_flag=0
               place_error_flag=0
               while [ $place_flag -eq 0 ]
               do
                     if [ $place_error_flag -eq 1 ]
                     then
                         echo -e "$(tput setaf 1)\nPlease enter a Place which contains only alphabets, spaces and atlest of 3 character\n$(tput sgr 0)Try again to enter a valid Place\n"
                     fi
            	     read -p "Please enter the new Place: " place
                    validate_entry $option 
               done            
               ;;
            6) read -p "Please enter the new Message: " message
               ;;
            7) date_time=`date +'%d-%m-%Y,%H:%M:%S'`
               sed -i "$data_position"s/.*/"$date_time,$name,$email,$tel_no,$mob_no,$place,$message"/ "$database_file"
               ;;
            x) edit_exit_flag=1
               ;;
            *) echo "$(tput setaf 1)Please coose the correct option!$(tput sgr 0)"
	       sleep $short_delay
          esac
    done	
}

#============================= search_operation function definition ===============================

function search_operation()
{
	# TODO Ask user for a value to search
	# 1. Value can be from any field of an entry.
	# 2. One by one iterate through each line of database file and search for the entry
	# 3. If available display all fiels for that entry
	# 4. Prompt error incase not available
	 search_exit_flag=0
	 #calling variable_clear function
         variable_clear
	 #calling page_title function
         page_title	
         echo -e "$(tput setab 6)$(tput bold)     Search / Edit Screen       $(tput sgr 0)\n"  	
         echo -e "\n$(tput setaf 4)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
         echo -e "\n$(tput setaf 1)$(tput bold)Search$(tput sgr 0) / Edit by:\n"
         #calling field_menu function
         field_menu
         case $choice in
            1) read -p "Please enter the Name: " name
               #calling array_search function
               array_search 3 "$name" name
               ;;
            2) read -p "Please enter the Email: " email
               #calling array_search function
               array_search 4 "$email" E-mail
               ;;
            3) read -p "Please enter the Telephone Number: " tel_no
               #calling array_search function
               array_search 5 "$tel_no" "Telephone Number"
               ;;
            4) read -p "Please enter the Mobile Number: " mob_no
               mob_no="+91-$mob_no"
               #calling array_search function
               array_search 6 "$mob_no" "Mobile Number"
               ;;
            5) read -p "Please enter the Place: " place
               #calling array_search function
               array_search 7 "$place" Place
               ;;
            6) read -p "Please enter the Message: " message
               #calling array_search function
               array_search 8 "$message" message
               ;;
            x) edit_exit_flag=1
               ;;
            *) echo "$(tput setaf 1)Please coose the correct option!$(tput sgr 0)"
	       sleep $short_delay
          esac
}

#============================== search_and_edit function definition ================================

function search_and_edit()
{
    # TODO UI for editing and searching 
    # 1. Show realtime changes while editing
    # 2. Call above functions respectively
    edit_exit_flag=0							#initializing the edit_exit_flag to continue the while loop
    while [ $edit_exit_flag -eq 0 ]
    do
         #calling page_title function
         page_title	
         echo -e "$(tput setab 6)$(tput bold)     Search / Edit Screen       $(tput sgr 0)\n" 	
         echo -e "\n$(tput setaf 4)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
         echo -e "\n$(tput setaf 1)$(tput bold)Search$(tput sgr 0) / Edit by:\n"
         #calling field_menu function
         field_menu
         read -p "Please choose the field to be searched: " choice
         #calling search_operation function
         search_operation
         if [ "$search_exit_flag" -eq 0 ]
         then
             #calling edit_operation function
             edit_operation
         fi
     done
}

#=============================== database_entry function definition =================================

function database_entry()
{
	# TODO user inputs will be written to database file
	# 1. If some fields are missing add consicutive ','. Eg: user,,,,,
	if [ ! -f database.csv ]
	then
	    touch "$database_file"
	fi
	date_time=`date +'%d-%m-%Y,%H:%M:%S'`
	echo "$date_time,$name,$email,$tel_no,$mob_no,$place,$message" >> "$database_file"
}

#=============================== validate_entry function definition =================================

function validate_entry()
{
	# TODO Inputs entered by user must be verified and validated as per fields
	# 1. Names should have only alphabets
	# 2. Emails must have a @ symbols and ending with .<domain> Eg: user@mail.com
	# 3. Mobile/Tel numbers must have 10 digits .
	# 4. Place must have only alphabets
	case $1 in
            1) # Name validation
               len_user=${#name}
               if [[ "$name" =~ ^[a-z' 'A-Z]+$ && "$len_user" -ge 3 ]]
	       then
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

#=============================== add_entry function definition =======================================

function add_entry()
{
    # TODO adding a new entry to database
    # 1. Validates the entries
    # 2. Add to database
    add_exit_flag=0							#initializing the add_exit_flag to continue the while loop
    while [ $add_exit_flag -eq 0 ]
    do
         #calling page_title function
         page_title	
         echo -e "$(tput setab 6)$(tput bold)     Add New Entry Screen       $(tput sgr 0)\n" 	
         echo -e "\n$(tput setaf 4)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
         #calling field_menu function
         field_menu
         read -p "Please choose the field to be added: " choice
         #calling page_title function
         page_title	
         echo -e "$(tput setab 6)$(tput bold)     Add New Entry Screen       $(tput sgr 0)\n" 	
         echo -e "\n$(tput setaf 4)$(tput bold)Please choose the below options: $(tput sgr 0)\n"
         #calling field_menu function
         field_menu
         case $choice in
            1) name_flag=0
               name_error_flag=0
               while [ $name_flag -eq 0 ]
               do
                     if [ $name_error_flag -eq 1 ]
                     then
                         echo -e "$(tput setaf 1)\nPlease enter a name which contains only alphabets, spaces and atlest of 3 character\n$(tput sgr 0)Try again to enter a valid name\n"
                     fi
            	     read -p "Please enter the Name: " name
                    validate_entry 1
               done
               ;;
            2) mail_flag=0
               mail_error_flag=0
               while [ $mail_flag -eq 0 ]
               do
                    if [ $mail_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf 1)\nPlease enter a valid E-mail ID\n$(tput sgr 0)Try again to enter a valid E-mail ID\n"
                    fi    
                    read -p "Please enter the Email: " email
                    validate_entry 2
               done
               ;;
            3) tel_flag=0
               tel_error_flag=0
               while [ $tel_flag -eq 0 ]
               do
                    if [ $tel_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf 1)\nPlease enter a valid Telephone Number\n$(tput sgr 0)Try again to enter a valid Telephone Number\n"
                    fi    
                    read -p "Please enter the Telephone Number: " tel_no
                    validate_entry 3
               done
               ;;
            4) mob_flag=0
               mob_error_flag=0
               while [ $mob_flag -eq 0 ]
               do
                    if [ $mob_error_flag -eq 1 ]
                    then
                        echo -e "$(tput setaf 1)\nPlease enter a valid Mobile Number\n$(tput sgr 0)Try again to enter a valid Mobile Number\n"
                    fi    
                    read -p "Please enter the Mobile Number: " mob_no
                    validate_entry 4
               done            
               ;;
            5) place_flag=0
               place_error_flag=0
               while [ $place_flag -eq 0 ]
               do
                     if [ $place_error_flag -eq 1 ]
                     then
                         echo -e "$(tput setaf 1)\nPlease enter a Place which contains only alphabets, spaces and atlest of 3 character\n$(tput sgr 0)Try again to enter a valid Place\n"
                     fi
            	     read -p "Please enter the Place: " place
                    validate_entry 5 
               done            
               ;;
            6) read -p "Please enter the Message: " message
               ;;
            x) #calling database_entry function
               database_entry
               add_exit_flag=1
               ;;
            *) echo "$(tput setaf 1)Please coose the correct option!$(tput sgr 0)"
	       sleep $short_delay
          esac
     done
}

#========================================= main script ===============================================

exit_flag=0							#initializing the exit_flag to continue the while loop
while [ $exit_flag -eq 0 ]
do
    #calling variable_clear function
    variable_clear
    #calling menu_header function
    menu_header
    read -p "Please choose your option: " choice		#taking user choice
    case $choice in	
            1) add_entry 					#calling add_entry function if user choose option 1
	       ;;
    	    2) search_and_edit					#calling search_and_edit function if user choose option 2
	       ;;
    	    x) exit_flag=1					#setting exit_flag to come out of the while loop if user choose option 3
    	       ;;
	    *)  #defualt condition if the user entered some other value
	       echo "$(tput setaf 1)Please coose the correct option!$(tput sgr 0)"
	       sleep $short_delay						#delay
    	       ;;
     esac
done     
