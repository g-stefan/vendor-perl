@echo off
rem Public domain
rem http://unlicense.org/
rem Created by Grigore Stefan <g_stefan@yahoo.com>

echo -^> install vendor-perl

set INSTALL_PATH=%XYO_PATH_REPOSITORY%\opt\perl
set INSTALL_PATH_BIN=%INSTALL_PATH%
set INSTALL_PATH_DEV=%INSTALL_PATH%

rem // ---

call build\msvc.install.sub.cmd
