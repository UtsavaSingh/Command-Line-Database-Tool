# Command-Line-Database-Tool
Database is a BASH shell based tool that is providing various operations to handle a particular database.

## Project Brief
------------------
A simple shell script (named "database.sh" will be called as "script" in description) which is capable of manipulating address database. Using this script user should able to store the information, view the information and to edit the information.

## Introduction
-----------------
Address Database is one of the BASH shell based Linux Shell Scripting Projects that is providing various operations to handle a particular database. Initially the data-base need to be pre-populated with some data for which the user will be provided with a set of commands (ex: add / modify / delete / search) using which he should be able to modify them. Practically database operations are performed in web applications whenever they are dealing with data. Popularly known as CRUD (Create / Read / Write / Delete) operations, they mainly help to deal with the backend database.  

The idea of this project is to implement an address book database management system using BASH Shell scripting and a local text based database. Along with this user functionality, this tool also record all the actions performed along with time-stamps for future references. Since the idea of this tool is to exposure SHELL programming, CSV file is used as a data-base storing entity.

### Project Details
--------------------
This Linux Shell Scripting Project is Divided into various functional areas. 

* __Activity log file:__
  * Every activity while the script is to be logged in file named database.log.
  * Attaches timestamp to every entry.
  
* __Working environment settings:__
  * Creates a file named “database.csv” under current directory if it doesn’t exist.
  * Checks the existence of at least one valid data entry in database.csv.
  * If the file is empty, script would only prompt for data addition unless and until it gets a valid entry to display.
  
* __User interface:__
  * The script have the following functionalities as listed below
    1. Add Entry
    2. Search / Edit Entry
    
* __Add Entry:__
  * When the user selects the “Add Entry” option it have the following fields to be added
  * Name
    * Accepts the user entry in any case but convert it to sentence case while storing.
    * Accepts only alphabets and spaces
    
  * E-mail
    * Accept only symbols like “.”, “_”, alphabets, and numbers. Validate for “@” and a “.” after it
    
  * Telephone Number
    * Accept only numbers
    
  * Mobile Number
    * Adds country code (assuming Indian customers)
    * Validates for 10 digit entry
    * Accepts only numbers
    
  * Place
    * Accepts the user entry in any case but converts it to sentence case while storing
    * Accepts only alphabets and spaces
    
  * Message
    * Any character allowed
    * No formatting has done, user entry captured as is.
  
  * When the user finishes all the above fields the information will be stored with current “date” and “time” automatically.  

* __Search / Edit Entry__  
  This feature have option to search an entry with any parameters you have in add entry, like
    * Name
    * Place
    * Message
      etc.,
      
  Once the search pattern matches, It will have provision to edit it and save

* __Time-out:__
  * The script will time out if the user input is absent for more than 10 seconds.


