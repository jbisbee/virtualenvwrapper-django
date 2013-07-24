# virtualenvwrapper-django #

Django project friendly virtualenvwrapper postactivate and postdeactivate bash scripts.  Postactivate creates a manage.py alias, **manage**, that allows you can run from manage.py from **anywhere** and also sets your DJANGO\_SETTINGS\_MODULE environment variable by introspecing your project's directory.

So in short, it does the following everytime you *workon* a Django project and then unsets them when you leave.

```bash
alias manage="python /absolute/path/to/your/django/projects/manage.py"
export DJANGO_SETTINGS_MODULE="python.module.name.of.your.settings"
```

### Installation ###

**1. Make sure your WORKON_HOME dirctory is defined for virtualenvwrapper**

```console
jbisbee@tacquito:~$ echo $WORKON_HOME
/home/jbisbee/.virtualenvs
```

**2. Pick a directroy where you want checkout to live (~/bin, ~/src, etc)**

```console
jbisbee@tacquito:~$ export VIRTUALENVWRAPPER_DJANGO_DIR=~/src
jbisbee@tacquito:~$ echo $VIRTUALENVWRAPPER_DJANGO_DIR
/home/jbisbee/src
```

**3. Checkout into that dir**

```console
jbisbee@tacquito:~$ cd $VIRTUALENVWRAPPER_DJANGO_DIR
jbisbee@tacquito:~/src$ git clone https://github.com/jbisbee/virtualenvwrapper-django.git
```

**4. Append supplement existings hooks with bash source commands to the ones within the project**

```console
jbisbee@tacquito:~/src$ echo "source $VIRTUALENVWRAPPER_DJANGO_DIR/virtualenvwrapper_django/postactivate" >> $WORKON_HOME/postactivate
jbisbee@tacquito:~/src$ echo "source $VIRTUALENVWRAPPER_DJANGO_DIR/virtualenvwrapper_django/postdeactivate" >> $WORKON_HOME/postdeactivate
```

**5. Now cat each file to make sure you accidently append it twice. Sould look something like this.  You're done!**

```console
jbisbee@tacquito:~/src$ cat $WORKON_HOME/postactivate
#!/bin/bash
# This hook is run after every virtualenv is activated.

source /home/jbisbee/src/virtualenvwrapper-django/postactivate
jbisbee@tacquito:~/src$ cat $WORKON_HOME/postdeactivate
#!/bin/bash
# This hook is run after every virtualenv is deactivated.

source /home/jbisbee/src/virtualenvwrapper-django/postdeactivate
```

*__Note:__ If you run into any problems with these install instructions let me know.  I tried to be
generic as possible without having to maintain an install script that hides the logic form you (and
most likely assumes things and gets the important bits wrong).  I would love to help you figure out
why things didn't work and update the instructions accoridngly.  Don't get discouraged! :D  Thank
you very much John Barry for the idea!*

### How Settings are Found ###

The current function looks for settings in the following locations. 

1. django\_project\_dir/\*/settings/USER.py
2. django\_project\_dir/\*/settings/dev.py
3. django\_project\_dir/\*/settings.py

*The USER environment variable may be overridden with the DJANGO_VIRTUALENVWRAPPER_USER from your .bashrc file (in case you use vagrant like me)*

```bash
export DJANGO_SETTINGS_MODULE="spock.settings.jbisbee"
export DJANGO_SETTINGS_MODULE="spock.settings.dev"
export DJANGO_SETTINGS_MODULE="spock.settings"
```

Now you'll be able to run commands that require settings without hardcoding the settings environment variable or passing in --settings manually. 

```console
(spock)jbisbee@tacquito:~/src/spock$ manage dbshell
...
mysql>
```

### Clean things up when you leave... (postdeactivate)###

```bash
unset DJANGO_SETTINGS_MODULE
unalias manage >/dev/null 2>/dev/null
```

*__Disclaimer:__ If you manage your Django project's settings differently let me know. I'd love to make the determine_django_module_settings more flexible and patches are more than welcome!*

### Authors ###

* Jeff Bisbee
* Mike Kreitman
* John Barry
