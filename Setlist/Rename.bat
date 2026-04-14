@echo off
setlocal enabledelayedexpansion

set "root="

for /d %%F in ("%root%\*") do (
    set "folder=%%~nxF"
    set "newname=!folder!"

    for /l %%Y in (1980,1,2026) do (
        rem remove (YYYY)
        set "newname=!newname:(%%Y)=!"
        rem remove [YYYY]
        set "newname=!newname:[%%Y]=!"
        rem remove YYYY -
        set "newname=!newname:%%Y - =!"
        rem remove - YYYY
        set "newname=!newname: - %%Y=!"
    )

    for /f "tokens=* delims= " %%X in ("!newname!") do set "newname=%%X"
    if "!newname:~0,1!"=="-" set "newname=!newname:~1!"
    for /f "tokens=* delims= " %%X in ("!newname!") do set "newname=%%X"

    if not "!folder!"=="!newname!" ren "%%F" "!newname!"

    for /d %%A in ("%%F\*") do (
        set "sub=%%~nxA"
        set "subclean=!sub!"
        for /f "tokens=1,2 delims= -" %%P in ("!subclean!") do (
            if /i "%%P"=="CD"   set "subclean=CD-%%Q"
            if /i "%%P"=="Disc" set "subclean=CD-%%Q"
        )
        if not "!sub!"=="!subclean!" ren "%%A" "!subclean!"
    )
)

echo DONE
pause
