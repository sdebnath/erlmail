@echo off
REM erl.exe adn erlc.exe must be in your path for this build file to work

echo Cleanup ...
del /q ebin\*.beam ebin\*.dump

echo Building ...
cd src
FOR %%f IN (*.erl) DO erlc.exe -W -o ../ebin %%f
cd ..
