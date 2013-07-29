#!/bin/bash

if [[ -z "$WORKON_HOME" ]]
then
    echo "Environment variable WORKON_HOME is not defined "
    echo "  Most likely you have not yet setup virtualenvwrapper"
    echo "  correctly."
    echo " "
    echo "    \# .bashrc example"
    echo "    WORKON_HOME=\$HOME/.virtualenvs"
    echo " "
    exit 1
fi

if [[ -z "$DJANGO_PROJECTS_SRC_DIR" ]]
then
    echo "Environment variable DJANGO_PROJECTS_SRC_DIR is not defined"
    echo "  It should be set to the directory where you checkout your"
    echo "  code."
    echo "    \# .bashrc example"
    echo "    DJANGO_PROJECTS_SRC_DIR=\$HOME/src"
    echo " "
    exit 1
fi

virtualenvwrapper_django_postactivate_file="$DJANGO_PROJECTS_SRC_DIR/virtualenvwrapper-django/postactivate"
virtualenvwrapper_django_postdeactivate_file="$DJANGO_PROJECTS_SRC_DIR/virtualenvwrapper-django/postdeactivate"

target_postactivate_file="$WORKON_HOME/postactivate"
target_postdeactivate_file="$WORKON_HOME/postdeactivate"

if [[ ! -e "$virtualenvwrapper_django_postactivate_file" ]]
then
    echo "Unable to find include $virtualenvwrapper_django_postactivate_file"
    exit 1
fi

if [[ ! -e "$virtualenvwrapper_django_postdeactivate_file" ]]
then
    echo "Unable to find include $virtualenvwrapper_django_postdeactivate_file"
    exit 1
fi

if [[ ! -e "$target_postactivate_file" ]]
then
    echo "Unable to find target file $target_postdeactivate_file"
    exit 1
fi

if [[ ! -e "$target_postdeactivate_file" ]]
then
    echo "Unable to find target file $target_postdeactivate_file"
    exit 1
fi

found_activate=$(grep "$virtualenvwrapper_django_postactivate_file" "$target_postactivate_file")
found_deactivate=$(grep "$virtualenvwrapper_django_postdeactivate_file" "$target_postdeactivate_file")

if [[ -z "$found_activate" ]]
then
    echo "installing virtualenvwrapper-django postactivate"
    $(echo "source $virtualenvwrapper_django_postactivate_file" >> "$target_postactivate_file")
else
    echo "virtualenvwrapper-django postactivate has already been installed"
fi

if [[ -z "$found_deactivate" ]]
then
    echo "installing virtualenvwrapper-django postdeactivate"
    $(echo "source $virtualenvwrapper_django_postdeactivate_file" >> "$target_postdeactivate_file")
else
    echo "virtualenvwrapper-django postdeactivate has already been installed"
fi
