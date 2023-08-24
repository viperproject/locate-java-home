@echo off

set "SOFT64=HKEY_LOCAL_MACHINE\SOFTWARE"
set "SOFT32=HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node"

@REM create temp files
set "dup=%TEMP%\find-java_dup.txt"
set "dedup=%TEMP%\find-java_dedup.txt"
type nul>%dup%
type nul>%dedup%

@REM Oracle
for /f "tokens=2,*" %%i in ('reg query "%SOFT64%\JavaSoft" /s 2^>nul ^| find " JavaHome "') do @echo %%j >> %dup%
for /f "tokens=2,*" %%i in ('reg query "%SOFT32%\JavaSoft" /s 2^>nul ^| find " JavaHome "') do @echo %%j >> %dup%

@REM Eclipse Adoptium
for /f "tokens=2,*" %%i in ('reg query "%SOFT64%\Eclipse Adoptium" /s 2^>nul ^| find " Path "') do @echo %%j >> %dup%
for /f "tokens=2,*" %%i in ('reg query "%SOFT32%\Eclipse Adoptium" /s 2^>nul ^| find " Path "') do @echo %%j >> %dup%

@REM Microsoft
for /f "tokens=2,*" %%i in ('reg query "%SOFT64%\Microsoft\JDK" /s 2^>nul ^| find " Path "') do @echo %%j >> %dup%
for /f "tokens=2,*" %%i in ('reg query "%SOFT32%\Microsoft\JDK" /s 2^>nul ^| find " Path "') do @echo %%j >> %dup%

@REM IBM Semeru
for /f "tokens=2,*" %%i in ('reg query "%SOFT64%\Semeru" /s 2^>nul ^| find " Path "') do @echo %%j >> %dup%
for /f "tokens=2,*" %%i in ('reg query "%SOFT32%\Semeru" /s 2^>nul ^| find " Path "') do @echo %%j >> %dup%

@REM Azul Zulu
for /f "tokens=2,*" %%i in ('reg query "%SOFT64%\Azul Systems\Zulu" /s 2^>nul ^| find " InstallationPath "') do @echo %%j >> %dup%
for /f "tokens=2,*" %%i in ('reg query "%SOFT32%\Azul Systems\Zulu" /s 2^>nul ^| find " InstallationPath "') do @echo %%j >> %dup%

@REM BellSoft Liberica
for /f "tokens=2,*" %%i in ('reg query "%SOFT64%\BellSoft\Liberica" /s 2^>nul ^| find " InstallationPath "') do @echo %%j >> %dup%
for /f "tokens=2,*" %%i in ('reg query "%SOFT32%\BellSoft\Liberica" /s 2^>nul ^| find " InstallationPath "') do @echo %%j >> %dup%

@REM remove duplicate rows
sort /unique %dup% /o %dedup%

@REM print result
for /f "tokens=*" %%i in (%dedup%) do echo %%i

@REM remove temp files
del /f "%dup%"
del /f "%dedup%"
