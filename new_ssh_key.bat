@echo off
title New SSH Key (Finney Robotics)
echo Creating a new SSH key for use with GitHub.

set /p user_name=Enter your name (no capitalization, punctuation, spaces, etc.): 
set /p user_email=Enter your GitHub email: 

ssh-keygen -t ed25519 -f %USERPROFILE%\.ssh\%user_name%_github -C "%user_email%"

(
echo Host github.com-%user_name%
echo   IdentityFile C:\Users\FinneyRobo\.ssh\%user_name%_github
echo   HostName github.com
echo   User git
) >> %USERPROFILE%\.ssh\config

printf "\n\nWhen cloning a new repository, instead of doing\n"
printf "  git clone git@github.com:<name>/<repo>.git\n"
printf "you should do\n"
printf "  git clone git@github.com-%user_name%:<name>/<repo>.git\n"
printf "\nFor example\n"
printf "  git@github.com-%user_name%:FRC-Team-1405/2021ROBOT.git\n\n"
printf "Add the following to your GitHub SSH keys:\n"

cat %USERPROFILE%\.ssh\%user_name%_github.pub

pause

