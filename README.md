# GitSandbox
Testing area for Git / GitHub 

Use 'manage credentials' to remove any cached GitHub credentials.

git config --global --unset user.name 
git config --global --unset user.email
git config --global user.useConfigOnly true
git config --system --unset credential.helper
git config --local user.name "First Last"
git config --local user.email name@mail.com
git config --global --edit
[core]
    askpass = 

The username and email are now local (repo based) and not global. The credentails will not be cached by the OS and will be prompted for username / password each time. However the push author is the user.name ad user.email not the credentials used to push.
