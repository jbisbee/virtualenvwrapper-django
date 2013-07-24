# virtualenvwrapper-django #

Django Project Friendly virtualenvwrapper postactivate and postdeactivate Bash Scripts.  Create a manage.py alias called manage that you can run from **anywhere**.  Also dynamically sets your DJANGO\_SETTINGS\_MODULE environment variable by searching your Django project.

So in short it basically does this everytime you *workon* a Django project and then unsets them when you leave.

```bash
alias manage="python /absolute/path/to/your/django/projects/manage.py"
export DJANGO_SETTINGS_MODULE="python.module.name.of.your.settings"
```

It accomplishes this via postactivate and postdeactive bash hooks

### How Settigns are Found ###

The current bash function looks for settings in the following locations.  USER is the USER environment variable and can be overridden with DJANGO_VIRTUALENVWRAPPER_USER set in your .bashrc file (useful if you use vagrant like me)

1. django\_project\_dir/\*/settings/USER.py
2. django\_project\_dir/\*/settings/dev.py
3. django\_project\_dir/\*/settings.py

Once a Django settings file is found it turns it into the python module equivilant and exports as the DJANGO_SETTINGS_MODULE environement variable.

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
