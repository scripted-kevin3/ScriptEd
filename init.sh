#!/bin/bash 
function prompt_yes_no {
    while true; do
    read -p "$@ " yn
    case $yn in
        [Yy]* ) let yesno_val=1; return;;
        [Nn]* ) let yesno_val=0; return;;
        * ) echo "Please answer yes or no. ";;
    esac
done
}

function prompt {
    read -p "$@ " prompt_val
}

function setup {
    prompt "Please enter your email"
    email="$prompt_val"
    prompt "Please enter your github username"
    username="$prompt_val"
   
   
    echo "Your email is $email"
    echo "Your username is $username"

    prompt_yes_no "Continue? " 
    if [ $yesno_val -eq 1 ] 
    then
        git config --global user.email $email
        git config --global user.name $username


        git init
        git remote add origin https://github.com/$username/ScriptEd
        heroku login
        heroku apps:create scripted-$username
        touch index.php
        echo "<?php include_once('index.html'); ?>" > index.php

        echo "ScriptEd initialized successfully!  You can now save and deploy your files"

    fi
}


prompt_yes_no "Initialize ScriptEd in this directory?"
if [ $yesno_val -eq 1 ] 
then 
  setup
fi