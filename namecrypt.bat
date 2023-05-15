@echo off

cd crypt
if errorlevel==1 (goto help)
set oe=outputEN.tmp
set od=outputDE.tmp
set ox=output.txt

setlocal EnableDelayedExpansion
for %%x in ("*") do (
    :retry
    set a=!random!!random!!random!!random!!random!!random!
    if exist !a! goto :retry
    ren "%%x" "!a!"
    echo renamed file "%%x" to "!a!" 
    echo "%%x" "!a!">>!oe!
    echo "!a!" "%%x">>!od!
)
endlocal

timeout 10

move %oe% ..\ & move %od% ..\ 
cd ..
echo @echo off>%ox%
echo :reset>>%ox%
echo set /p crypt=En- / De -crypt? (1/0) : >>%ox%
echo if %%crypt%%==1 (goto EN)>>%ox%
echo if %%crypt%%==0 (goto DE)>>%ox%
echo goto reset>>%ox%

echo :EN>>%ox%
for /F "tokens=*" %%x in (%oe%) do (
    echo ren %%x>>%ox%
)
echo exit>>%ox%

echo :DE>>%ox%
for /F "tokens=*" %%x in (%od%) do (
    echo ren %%x>>%ox%
)
echo exit>>%ox%

del %oe% & del %od%

goto exit

:help
Echo Create a folder with the name "crypt", the files in this folder will be renamed.
Echo This message is displayed because there is no "crypt" folder.
pause

:exit
exit