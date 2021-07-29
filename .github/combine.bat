:COMBINEMAPS

CLS

ECHO.
ECHO.
ECHO  *** COMBINE MAPS ***
ECHO.
ECHO.
ECHO What type of map are you combining?
ECHO.
ECHO  S) vSTARS
echo.
echo  E) vERAM
ECHO.
ECHO.

SET GOAL=-

:COMB_CHOICE

SET /P GOAL=Type S or E and press Enter: 
	if /i %GOAL%==S GOTO COMBINEVM
	if /i %GOAL%==E GOTO COMBINEGEO
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %GOAL% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto COMB_CHOICE

:COMBINEVM

CLS

CD /D "%userprofile%\OneDrive\Documents\Github\ZAB-FE\EDIT vSTARS Video Maps"

ECHO.
ECHO.
SET /P FAC_ID=Type the three character abbreviation of the facility video maps you wish to combine and press Enter: 
	SET FAC_ID=%FAC_ID: =%

IF NOT EXIST %FAC_ID% (
ECHO.
ECHO.
ECHO **********  ERROR  **********
ECHO.
ECHO  DIRECTORY NOT FOUND:
ECHO.
ECHO  %userprofile%\OneDrive\Documents\Github\ZAB-FE\...
ECHO   ...EDIT vSTARS Video Maps\%FAC_ID%
ECHO.
ECHO  TRY AGAIN...
ECHO.
PAUSE
GOTO COMBINEVM
)

CLS

ECHO.
ECHO.
ECHO  *** COMBINE VIDEO MAPS ***
ECHO.
ECHO.
ECHO.
ECHO.
ECHO Is this where all of the .xml files that you want to combine are located?
ECHO.
ECHO  %userprofile%\OneDrive\Documents\Github\ZAB-FE\...
ECHO   ...EDIT vSTARS Video Maps\%FAC_ID%
ECHO.
ECHO.

:VM-DIR_CHOICE

set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set SOURCE_DIR=%userprofile%\OneDrive\Documents\Github\ZAB-FE\EDIT vSTARS Video Maps\%FAC_ID%
	if /i %USERSELECT%==Y GOTO STRT_COMBVM
	if /i %USERSELECT%==N GOTO VM-SRC_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto VM-DIR_CHOICE

:VM-SRC_DIR

CLS

ECHO.
ECHO.
ECHO Select the directory that hosts the individual .xml files.
ECHO.
ECHO.

SET SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the directory that hosts the individual .xml files',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B

:STRT_COMBVM

CLS

CD "%SOURCE_DIR%"

IF EXIST COMBINED RD /Q /S COMBINED
MD COMBINED

TYPE *.xml>"%SOURCE_DIR%\COMBINED\%FAC_ID% Video Maps.xml"

:COMBVM_DONE

CLS

ECHO.
ECHO.
ECHO DONE
ECHO.
ECHO.
ECHO You may find %FAC_ID% Video Maps.xml HERE:
ECHO.
ECHO   %SOURCE_DIR%\COMBINED
ECHO.
ECHO.
ECHO.
ECHO.
ECHO ---------------------------------------------------------
ECHO.
ECHO Do you want to have the new combined file replace
ECHO the %FAC_ID% Video Maps.xml that should be located here?:
ECHO.
ECHO %AppData%\vSTARS\Video Maps
ECHO.
ECHO.

:VM_DONE_CH
	
set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y GOTO REPLACE_VM
	if /i %USERSELECT%==N GOTO HELLO2
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto VM_DONE_CH

:REPLACE_VM

COPY "%SOURCE_DIR%\COMBINED\%FAC_ID% Video Maps.xml" "%AppData%\vSTARS\Video Maps"

CLS

ECHO.
ECHO.
ECHO MOVED THE COMBINED %FAC_ID% Video Maps.xml to:
ECHO.
ECHO %AppData%\vSTARS\Video Maps
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:COMBINEGEO

CLS

ECHO.
ECHO.
ECHO  *** COMBINE GEO MAPS ***
ECHO.
ECHO.
ECHO.
ECHO.
ECHO Is this where all of the .xml files that you want to combine are located?
ECHO.
ECHO  %userprofile%\OneDrive\Documents\Github\ZAB-FE\...
ECHO   ...EDIT vERAM GeoMaps\SPLIT MAPS
ECHO.
ECHO.

:SRC_DIR_CHOICE

set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set SOURCE_DIR=%userprofile%\OneDrive\Documents\Github\ZAB-FE\EDIT vERAM GeoMaps\SPLIT MAPS
	if /i %USERSELECT%==Y GOTO STRT_COMBGEO
	if /i %USERSELECT%==N GOTO CSE_SRC_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto SRC_DIR_CHOICE

:CSE_SRC_DIR

CLS

ECHO.
ECHO.
ECHO Select the directory that hosts the individual .xml files.
ECHO.
ECHO.

SET SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the directory that hosts the individual .xml files',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B

:STRT_COMBGEO

CLS

CD "%SOURCE_DIR%"

IF EXIST COMBINED RD /Q /S COMBINED
MD COMBINED

TYPE *.xml>"%SOURCE_DIR%\COMBINED\ZAB GeoMaps.xml"

:COMBGEO_DONE

CLS

ECHO.
ECHO.
ECHO DONE
ECHO.
ECHO.
ECHO You may find your ZAB GeoMaps.xml here:
ECHO.
ECHO   %SOURCE_DIR%\COMBINED
ECHO.
ECHO.
ECHO.
ECHO.
ECHO -------------------------------------------------
ECHO.
ECHO Do you want to have the new combined file replace
ECHO the ZAB GeoMaps.xml that should be located here?:
ECHO.
ECHO %userprofile%\AppData\Local\vERAM\GeoMaps
ECHO.
ECHO.

:CBGEO_DONE_CH
	
set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y GOTO REPLACE_GEO
	if /i %USERSELECT%==N GOTO HELLO2
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto CBGEO_DONE_CH

:REPLACE_GEO

COPY "%SOURCE_DIR%\COMBINED\ZAB GeoMaps.xml" "%userprofile%\AppData\Local\vERAM\GeoMaps"

CLS

ECHO.
ECHO.
ECHO MOVED THE COMBINED ZAB GeoMaps.xml to:
ECHO.
ECHO %userprofile%\AppData\Local\vERAM\GeoMaps
ECHO.
ECHO.

PAUSE
