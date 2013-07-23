# django-virtualenvwrapper #

Django Project Friendly virtualenvwrapper postactive and postdeactive Bash Files

### postactivate Gives You ###

**manage Bash Alias**

This gives you manage alias which is equvilant to

```bash
alias manage="python /absolute/path/to/your/django/projects/manage.py"
```

which allows you to run manage.py from anywhere once you load our virtual env

**Autoset Your Django Project's DJANGO\_SETTINGS\_MODULE Environment Variable**

The incluced postactivate hook introspects your project looking for a settings file in the following
places

1. django\_project\_dir/\*/settings/USER.py
2. django\_project\_dir/\*/settings/dev.py
3. django\_project\_dir/\*/settings.py

*USER can be overriden with DJANGO_VIRTUALENVWRAPPER_USER - if you use vagrant, etc*

Now you'll be able to run commands that require the DJANGO\_SETTINGS\_MODULE environment variable to
be set without passing in --settings.

```console
(spock)jbisbee@tacquito:~/src/spock$ manage dbshell
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 95
Server version: 5.5.31-0ubuntu0.12.04.2 (Ubuntu)

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

### postdeactivate Gives You ###

**Cleans up after postactive**

1. remove manage alias (silently incase it didn't get set)
2. unsets DJANGO\_SETTINGS\_MODULE


