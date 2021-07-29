@ECHO OFF

:HELLO

CLS

ECHO.
ECHO                                    **** NOTE ****
ECHO.
ECHO  This BATCH File will take every number sequenced file name and rename it starting with 10000
ECHO  and increasing by 100 for each file.
ECHO.
ECHO  This will only work if the file starts with a sequence number followed immediately
echo  by an underscore:
ECHO.
ECHO     EX:
ECHO        100020_Some name_here.txt
ECHO        1_Some name_here and stuff.xml
ECHO.
ECHO  This BATCH File MUST be in the same directory with all of the files that you wish to rename.
ECHO.
ECHO  Please ensure only the files that you wish to be renamed are in this directory.
ECHO.
ECHO  Type the file extension of the type of files you wish to renumber and press Enter.
ECHO  Once you press Enter, the process will start.
ECHO.
ECHO      *************************
ECHO.
ECHO       EXAMPLE: All .txt files
ECHO.
ECHO          TYPE: .txt
ECHO.
ECHO      *************************
ECHO.

SET /P EXTEN=

CLS

ECHO.
ECHO.
ECHO  ARE YOU SURE YOU WANT TO RENAME ALL %EXTEN% FILES IN THIS DIRECTORY?
ECHO.
ECHO  %CD%
ECHO.
ECHO.
ECHO.

SET /P CONFIRM="Type Y or N (case sensitive) and press Enter:"

	IF /i NOT "%CONFIRM%"=="Y" GOTO HELLO

SETLOCAL EnableDelayedExpansion

CD "%CD%"

SET /A COUNT=0

for /f "delims=" %%G in ('dir /b ^| findstr "%EXTEN%"') do (

	SET /A COUNT=!COUNT! + 1

	SET WHOLE_ORG_FILE_NAME=%%G
	
	for /f "usebackq tokens=1* delims=_" %%a in ('!WHOLE_ORG_FILE_NAME!') do (
	
		SET /A ORG_FILE_NUM=%%a
		
		SET BASE_NAME=%%b
		
		IF !COUNT!==1 SET /A NEW_FILE_NUM=100001
		IF NOT !COUNT!==1 SET /A NEW_FILE_NUM=!PREV_NUM! + 100
		
		REN "!WHOLE_ORG_FILE_NAME!" "!NEW_FILE_NUM!_!BASE_NAME!"
		
		SET /A PREV_NUM=!NEW_FILE_NUM!
	)
)

ECHO.
ECHO.
ECHO DONE
ECHO.

PAUSE