*** Settings ***

Library    SeleniumLibrary
Library    OperatingSystem    

*** Comments ***

OperatingSystem library is imported to create file.
Enter valid email and password to let the program work.
Used sleep command several times to have a better test experience.


*** Test Cases ***
   
LoginTest
    #Open chrome
    Open Browser    http://github.com/login    Chrome
    Maximize Browser Window
  
    #Enter login details and click button
    Input Text    id=login_field    youremail@email.com
    Input Text    id=password       yourpassword
    Click Button  xpath://input[@value='Sign in']
  
    #Click to avatar and enter to repositories  
    Click Image   xpath://img[@class='avatar-user avatar avatar-small ']
    Sleep    2s
    Click Link    link:Your repositories   
    Sleep    2s
    
    #Get repository names and define directory for the first txt file
    ${repoNames} =    Get Text    xpath://*[@id="user-repositories-list"]
    ${text_file} =     Set Variable    ${CURDIR}\\reponames.txt
 
    #Create first txt file and add repository names to the file   
    Create File    ${text_file}
    Append To File    ${text_file}    ${repoNames}    encoding=UTF-8
    
    #Search eksicode in searchbar and press enter                 
    Input Text    xpath:(//input[@name='q'])[1]    eksicode
    Press Keys    xpath:(//input[@name='q'])[1]    DOWN
    Press Keys    xpath:(//input[@name='q'])[1]    ENTER
    Sleep    1s  
    
    #Get repository names of eksicode user and define directory for the second txt file
    ${eksiRepoNames} =     Get Text    xpath://*[@id="js-pjax-container"]/div/div[3]/div/ul
    ${text_file2} =     Set Variable    ${CURDIR}\\eksireponames.txt

    #Create second txt file and add eksicode repository names to the file
    Create File    ${text_file2}  
    Append To File    ${text_file2}    ${eksiRepoNames}    encoding=UTF-8
    
    Close Browser             
   