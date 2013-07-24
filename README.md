# virtualenvwrapper-django #

Django project friendly virtualenvwrapper postactivate and postdeactivate bash scripts.  Postactivate creates a manage.py alias, **manage**, that allows you can run from manage.py from **anywhere** and also sets your DJANGO\_SETTINGS\_MODULE environment variable by introspecing your project's directory.

So in short, it does the following everytime you *workon* a Django project and then unsets them when you leave.

```bash
alias manage="python /absolute/path/to/your/django/projects/manage.py"
export DJANGO_SETTINGS_MODULE="python.module.name.of.your.settings"
```

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
