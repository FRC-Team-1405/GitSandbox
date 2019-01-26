# GitSandbox
Testing area for Git / GitHub 

Use 'manage credentials' to remove any cached GitHub credentials.

git config --global --unset user.name<br>
git config --global --unset user.email<br>
git config --global user.useConfigOnly true<br>
git config --system --unset credential.helper<br>
git config --local user.name "First Last"<br>
git config --local user.email name@mail.com<br>
git config --global --edit<br>
`[core]
    askpass =` 

The username and email are now local (repo based) and not global. The credentails will not be cached by the OS and will be prompted for username / password each time. However the push author is the user.name ad user.email not the credentials used to push.
