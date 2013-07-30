# virtualenvwrapper-django #

Django project friendly virtualenvwrapper postactivate and postdeactivate bash scripts.  Postactivate creates a manage.py alias, **manage**, that allows you can run from manage.py from **anywhere** and also sets your DJANGO\_SETTINGS\_MODULE environment variable by introspecing your project's directory.

So in short, it does the following everytime you *workon* a Django project and then unsets them when you leave.

```bash
alias $DJANGO_MANAGE_PY_ALIAS="python /absolute/path/to/your/django/projects/manage.py"
export DJANGO_SETTINGS_MODULE="python.module.name.of.your.settings"
```

*__Note:__

* DJANGO_MANAGE_PY_ALIAS defaults to __manage__, but you can override this behavior to use
any command you want from your .bashrc file.*
* DJANGO_VIRTUALENV_NAME_MAP defaults to ~/.django-virtualenv-name-map. Override this environment to change the location of the mapping.  The file consists of virtualenv name and django project names seperated by spaces.  [See below](#name-map-format) for file format example.


### Installation ###

**1. Make sure your WORKON_HOME dirctory is defined for virtualenvwrapper**

```console
jbisbee@tacquito:~$ echo $WORKON_HOME
/home/jbisbee/.virtualenvs
```

**2. Set DJANGO_PROJECTS_SRC_DIR to where you checkout code.  I use $HOME/src**

```bash
# .bashrc
export DJANGO_PROJECTS_SRC_DIR=$HOME/src
```

**3. Reload your .bashrc**
```console
jbisbee@tacquito:~$ source ~/.bashrc
```

**4. Checkout into that dir**

```console
jbisbee@tacquito:~$ cd $DJANGO_PROJECTS_SRC_DIR
jbisbee@tacquito:~/src$ git clone https://github.com/jbisbee/virtualenvwrapper-django.git
```

**5. Run the install script**

This install script simply ads a bash source line in virtualenvwrapper's postactivate and
postdeactivate hook files to source the postactivate and postdeactive from this project.  You don't
like it or its buggy, just comment out or remove the one source line.

```console
jbisbee@tacquito:~/src$ $DJANGO_PROJECTS_SRC_DIR/virtualenvwrapper-django/install.sh
installing virtualenvwrapper-django postactivate
installing virtualenvwrapper-django postdeactivate
```

**6. Now cat each file to make sure you accidently append it twice. Sould look something like this.**

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

**7. You're done!**

*__Note:__ If you run into any problems with these install instructions let me know.  I tried to be
generic as possible without having to maintain an install script that hides the logic form you (and
most likely assumes things and gets the important bits wrong).  I would love to help you figure out
why things didn't work and update the instructions accordingly.  Don't get discouraged! :D  Thank
you John Barry (via Google+) for the idea for these instructions!*

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
unalias $DJANGO_MANAGE_PY_ALIAS >/dev/null 2>/dev/null
```

*__Disclaimer:__ If you manage your Django project's settings differently let me know. I'd love to make the determine_django_module_settings more flexible and patches are more than welcome!*


### <a name="name-map-format"></a>Virtualenv name to Django Project Name Mapping ###

I made a big assumption when I originally wrote this extension that everyone would make their virtualenv names and project names the same.  I quickly found out this was not the case from two of my coworkers and I promised myself I would finally fix this problem.

I created a new environment variable called DJANGO_VIRTUALENV_NAME_MAP that defaults to $HOME/.django-virtualenv-name-map that you're free to override.  The file contents are as follows

```bash
# $HOME/.django-virtualenv-name-map

# virtualenv-name django-project-name
sparky sparky-django
union unionweb

```

### Change Log ###

**v1.4**
* Added DJANGO_VIRTUALENV_NAME_MAP environment variable and defaulted the value to 
  $HOME/.django-virtualenv-name-map.  The file format is a sample name value pair seperated by spaces.  
* Fix cd directory to attempt to cd to Django manage.py directory then fallback to the django project
  directory

**v1.3**
* Fixed bug if manage.py was not located in the root project directory.  Settings was
  correctly evaluated in this case to the wrong module name (mysite.mysite.settings instead
  of mysite.settings)
* Added an install.sh script that makes the install process easier.  You just need to set
  the DJANGO_PROJECTS_SRC_DIR variable for context, checkout the project in that directory
  and then run the install script.
* Feedback from a friend telling me I'm a bash newbie.  I was quoting bash variables when 
  I didn't need to.  (${1} should have just been $1, etc)

**v1.2**
* Added DJANGO_PROJECTS_SRC_DIR as a .bashrc override because I mistakenly assumed everyone
  uses $HOME/src to store their source code.

**v1.1**
* Added install instructions to the README
* Added DJANGO_MANAGE_PY_ALIAS environment variable to be able override the alias from just manage
* Added the Change Log (is this meta or what?)
* Added Authors Mike Kreitman, John Barry, and Ethan Soergel.  Thanks guys!

**v1.0**
* Initial release

### Authors ###

* **Jeff Bisbee**
* **Michael Kreitman** - a small bit of bash help turning a absolute file name into a relative one.  I
  could have done it in two seconds in python or perl, but bash still continues to throw me for a
  loop sometimes
* **John Barry** - feedback from Google+ on function typo (signature and caller) and the idea for the
  install instructions.
* **Ethan Soergel** - pointing me to his similar project called EmceeVirtualEnv on github and giving me
  the idea for the DJANGO_MANAGE_PY_ALIAS variable (able to override the alias)
* **Rafal Muszynski** - great feedback on the install process plus feedback on my less than
  spectacular bash skills.  He's my full blooded Polish brother.  Thanks Polish Hammer!

