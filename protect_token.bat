@echo off
REM usage: encrypt_token <token Name> <token value>
REM Encrypt the given token and generate the batch file <Token Name>.bat 
REM which decrypts the toekan to the clipboard. 

set decrypt_bat=%1.bat
set token=%2


for /f "usebackq tokens=*" %%p in (`powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)"`) do set password=%%p
for /f "usebackq tokens=*" %%p in (`powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)"`) do set validate=%%p

if NOT "%password%" == "%validate%" (
    echo Password mismatch
    exit 0
)

FOR /F "usebackq tokens=*" %%p in (`echo %token% ^| openssl aes-256-cbc -a -A -salt -pbkdf2 -pass pass:%password%`) do SET enc=%%p

echo Creating %decrypt_bat%

(
echo @echo off
echo for /f "usebackq tokens=*" %%%%p in ^(`powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)"`^) do set password=%%%%p
echo echo %%password%%
echo echo %enc% ^| openssl aes-256-cbc -d -a -salt -pbkdf2 -pass pass:%%password%% ^| clip

echo echo.
echo echo Your token has been copied to the clipboard.

echo timeout /t 30

echo echo. ^| clip

echo echo.
echo echo The clipboard has been cleared.
) > %token_bat%

