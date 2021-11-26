@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

set ACTION=%1
if "%1" == "" set ACTION=make

echo - %BUILD_PROJECT% ^> %1

goto cmdXDefined
:cmdX
%*
if errorlevel 1 goto cmdXError
goto :eof
:cmdXError
echo "Error: %ACTION%"
exit 1
:cmdXDefined

if not "%ACTION%" == "make" goto :eof

call :cmdX xyo-cc --mode=%ACTION% --source-has-archive perl

if not exist temp\ mkdir temp

set INCLUDE=%XYO_PATH_REPOSITORY%\include;%INCLUDE%
set LIB=%XYO_PATH_REPOSITORY%\lib;%LIB%
set WORKSPACE_PATH=%CD%
set WORKSPACE_PATH_BUILD=%WORKSPACE_PATH%\temp

if exist %WORKSPACE_PATH_BUILD%\build.done.flag goto :eof

if "%XYO_PLATFORM%" == "win64-msvc-2022" copy /Y /B build\source\Makefile.msvc64 source\win32\Makefile
if "%XYO_PLATFORM%" == "win32-msvc-2022" copy /Y /B build\source\Makefile.msvc32 source\win32\Makefile

if "%XYO_PLATFORM%" == "win64-msvc-2019" copy /Y /B build\source\Makefile.msvc64 source\win32\Makefile
if "%XYO_PLATFORM%" == "win32-msvc-2019" copy /Y /B build\source\Makefile.msvc32 source\win32\Makefile

if "%XYO_PLATFORM%" == "win64-msvc-2017" copy /Y /B build\source\Makefile.msvc64 source\win32\Makefile
if "%XYO_PLATFORM%" == "win32-msvc-2017" copy /Y /B build\source\Makefile.msvc32 source\win32\Makefile

pushd "source\win32"

nmake -f Makefile INST_DRV="%WORKSPACE_PATH_BUILD%"
if errorlevel 1 goto makeError
nmake -f Makefile INST_DRV="%WORKSPACE_PATH_BUILD%" install
if errorlevel 1 goto makeError

goto buildDone

:makeError
popd
echo "Error: make"
exit 1

:buildDone
popd
echo done > %WORKSPACE_PATH_BUILD%\build.done.flag
