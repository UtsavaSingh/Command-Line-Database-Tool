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

## Sample Output
-----------------
Here are the sample outputs by the end of Linux Shell Scripting Project execution.

|![](https://user-images.githubusercontent.com/82516591/186944931-4e2d6fce-5c9d-4cc6-9943-6a8bb178ff12.png)|
|:--:|
| <b>Fig1: Main Menu Proceeding towards Add Entry</b> |

|![](https://user-images.githubusercontent.com/82516591/186945453-0dcc0db5-c8cb-4cb1-af3f-1356c4ba1956.png)|
|:--:|
| <b>Fig2: Add Entry Screen</b> |

|![](https://user-images.githubusercontent.com/82516591/186945581-57c6ba3f-697d-413f-9da2-bbacd781e056.png)|
|:--:|
| <b>Fig3: Adding a new Contact with help of Name</b> |

|![](https://user-images.githubusercontent.com/82516591/186945768-ac87ff04-8ae6-49dd-892d-9efb89764905.png)|
|:--:|
| <b>Fig4: View of added contact. Proceeding to add Mobile Number</b> |

|![](https://user-images.githubusercontent.com/82516591/186946198-5cd39cc9-e948-4ee1-8c11-ec064f28743f.png)|
|:--:|
| <b>Fig5: Adding Mobile Number</b> |

|![](https://user-images.githubusercontent.com/82516591/186946305-020e1eed-b010-4464-b51e-5f8186063484.png)|
|:--:|
| <b>Fig6: Updated contact view. Proceeding to previous screen</b> |

|![](https://user-images.githubusercontent.com/82516591/186946429-b74fed01-a4cc-4669-a82c-2768b8f052e2.png)|
|:--:|
| <b>Fig7: Main Menu. Proceeding towards Search / Edit Entry</b> |

|![](https://user-images.githubusercontent.com/82516591/186946603-4e384d3e-00ed-4840-af96-1c7ba0123f33.png)|
|:--:|
| <b>Fig8: Search Menu, The Edit Menu will be similar once the item is searched</b> |

|![](https://user-images.githubusercontent.com/82516591/186946719-9799ee48-1119-4232-aa6e-2cb76053463f.png)|
|:--:|
| <b>Fig9: Search Menu. Proceeding towards Search by Name</b> |

|![Test completion screen](https://user-images.githubusercontent.com/82516591/186946826-3f3bea6b-80f7-4710-b63d-e28c46577f0b.png)|
|:--:|
| <b>Fig10: The name to be Searched</b> |

|![](https://user-images.githubusercontent.com/82516591/186947105-6ea804d8-9640-4fe0-a5e7-94550c6e549f.png)|
|:--:|
| <b>Fig11: Search Result, it's in Edit Menu now, Proceeding to add Place field</b> |

|![](https://user-images.githubusercontent.com/82516591/186947202-ab061ff0-a585-47ed-9d95-ed6671c33391.png)|
|:--:|
| <b>Fig12: Adding Place</b> |

|![](https://user-images.githubusercontent.com/82516591/186947464-4260ffea-0014-411c-9dd2-feb6bb8714f9.png)|
|:--:|
 <b>Fig13: Updated screen with Place. Proceeding to Save</b> |

|![](https://user-images.githubusercontent.com/82516591/186947724-61e2b426-cf04-4612-bf1e-efcc638cfecb.png)|
|:--:|
| <b>Fig14: Proceeding to Exit Search / Edit Screen</b> |

|![](https://user-images.githubusercontent.com/82516591/186947893-0983464c-2a36-4de7-9c5d-5c3da51fd4d9.png)|
|:--:|
| <b>Fig15: Back to Main Screen. Proceeding to Exit Script</b> |

|![](https://user-images.githubusercontent.com/82516591/186948024-3b4d828b-1da0-48a5-a79d-77140e546ab1.png)|
|:--:|
| <b>Fig16: The address database in .csv file format</b> |

|![](https://user-images.githubusercontent.com/82516591/186948200-0002b6c2-9767-4865-a830-032b43e0ff22.png)|
|:--:|
| <b>Fig17: Assuming multiple entries with same name, This is how the Search result will be shown. Selecting 2nd entry to Edit</b> |

|![](https://user-images.githubusercontent.com/82516591/186948361-2cf75594-164c-481c-8a56-4ce79ae5571a.png)|
|:--:|
| <b>Fig18: Selection of 2nd user to Edit</b> |

|![](https://user-images.githubusercontent.com/82516591/186948585-c0d9eb2c-7663-48e8-b8f6-5868c7ab1e33.png)|
|:--:|
| <b>Fig19: Script timed out</b> |

|![](https://user-images.githubusercontent.com/82516591/186948798-288e36e1-7335-484b-8004-de0f876b3e63.png)|
|:--:|
| <b>Fig20: User Activity Log file</b> |
