@echo off
setlocal enabledelayedexpansion

set "root="

for /r "%root%" %%F in (*.mp3) do (
    set "folder=%%~dpF"
    set "folder_no_slash=!folder:~0,-1!"

    for %%X in ("!folder_no_slash!") do set "foldername=%%~nxX"

    if "!foldername:~0,1!"=="[" (
        set "year=!foldername:~1,4!"
        for /f "delims=0123456789" %%Z in ("!year!") do set "nonDigit=%%Z"
        if "!nonDigit!"=="" if "!year!" geq "1980" if "!year!" leq "2026" (
            set "foldername=!foldername:~6!"
        )
    ) else if "!foldername:~0,1!"=="(" (
        set "year=!foldername:~1,4!"
        for /f "delims=0123456789" %%Z in ("!year!") do set "nonDigit=%%Z"
        if "!nonDigit!"=="" if "!year!" geq "1980" if "!year!" leq "2026" (
            set "foldername=!foldername:~6!"
        )
    ) else (
        set "year=!foldername:~0,4!"
        for /f "delims=0123456789" %%Z in ("!year!") do set "nonDigit=%%Z"
        if "!nonDigit!"=="" if "!year!" geq "1980" if "!year!" leq "2026" (
            set "foldername=!foldername:~5!"
        )
    )

    for /f "tokens=* delims= " %%Y in ("!foldername!") do set "foldername=%%Y"

    echo Processing MP3: %%F
    echo Saving cover as: !folder!!foldername!.jpg

    ffmpeg -i "%%F" -map 0:v:0 -c copy "!folder!!foldername!.jpg" -y
)

for /r "%root%" %%F in (*.flac) do (
    set "folder=%%~dpF"
    set "folder_no_slash=!folder:~0,-1!"

    for %%X in ("!folder_no_slash!") do set "foldername=%%~nxX"

    if "!foldername:~0,1!"=="[" (
        set "year=!foldername:~1,4!"
        for /f "delims=0123456789" %%Z in ("!year!") do set "nonDigit=%%Z"
        if "!nonDigit!"=="" if "!year!" geq "1980" if "!year!" leq "2026" (
            set "foldername=!foldername:~6!"
        )
    ) else if "!foldername:~0,1!"=="(" (
        set "year=!foldername:~1,4!"
        for /f "delims=0123456789" %%Z in ("!year!") do set "nonDigit=%%Z"
        if "!nonDigit!"=="" if "!year!" geq "1980" if "!year!" leq "2026" (
            set "foldername=!foldername:~6!"
        )
    ) else (
        set "year=!foldername:~0,4!"
        for /f "delims=0123456789" %%Z in ("!year!") do set "nonDigit=%%Z"
        if "!nonDigit!"=="" if "!year!" geq "1980" if "!year!" leq "2026" (
            set "foldername=!foldername:~5!"
        )
    )

    for /f "tokens=* delims= " %%Y in ("!foldername!") do set "foldername=%%Y"

    echo Processing FLAC: %%F
    echo Saving cover as: !folder!!foldername!.jpg

    ffmpeg -i "%%F" -map 0:v:0 -c copy "!folder!!foldername!.jpg" -y
)

echo.
echo DONE
pause
