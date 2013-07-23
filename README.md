# django-virtualenvwrapper #

Django Project Friendly virtualenvwrapper postactive and postdeactive Bash Files

## postactive Gives You ##

_manage Bash Alias_

This gives you manage alias which is equvilant to

  alias manage="python /absolute/path/to/your/django/projects/manage.py"

which allows you to run manage.py from anywhere once you load our virtual env

_Autoset Your Django Project's DJANGO\_SETTINGS\_MODULE Environment Variable_

The incluced postactivate hook introspects your project looking for a settings file in the following
places

1. django\_project\_dir/\*/settings/USER.py
2. django\_project\_dir/\*/settings/dev.py
3. django\_project\_dir/\*/settings.py

*USER can be overriden with DJANGO_VIRTUALENVWRAPPER_USER - if you use vagrant, etc*

Now you'll be able to run commands that require the DJANGO\_SETTINGS\_MODULE environment variable to
be set without passing in --settings or getting the warning reminding you to set it.

  manage dbshell

## postdeactivate Gives You ##

_Cleans up after postactive_

1. remove manage alias (silently incase it didn't get set)
2. unsets DJANGO\_SETTINGS\_MODULE


