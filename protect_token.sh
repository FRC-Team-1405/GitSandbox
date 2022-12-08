#!/usr/bin/env bash

# alias the clipboard
if [[ "$OSTYPE" == "darwin"* ]]; 
then    # Mac OSX
    clpbrd='pbcopy'
elif [[ "$OSTYPE" == "msys" ]]; 
then    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    clpbrd='clip'
else    # Unknown.
    echo "Unknown OS: $OSTYPE"
    exit 0
fi
decrypt_sh="$1.sh"
token=$2


read -s -p "Enter Password" password
echo ""
read -s -p "Verify Password" verify
echo ""
if [ $password != $verify ];
then
    echo "Password mismatch"
    exit 0
fi

# encrypt the token
enc=`echo $token | openssl aes-256-cbc -a -A -salt -pbkdf2 -pass pass:$password`

echo "Creating $decrypt_sh"
# create a decrypt script
cat > "$decrypt_sh" << EOF
#!/usr/bin/env bash
read -s -p "Enter Password" password
echo ""
echo "$enc" | openssl aes-256-cbc -d -a -salt -pbkdf2 -pass pass:\$password | $clpbrd
echo "Your token has been copied to the clipboard." 
sleep 30
echo "" | $clpbrd
echo "The clipboard has been cleared."
EOF

# set the execute mode
chmod +x $decrypt_sh