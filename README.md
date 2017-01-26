### python

This container has the following characteristics:
- Container nfqsolutions/centos:7.
- Java 7u80 installed.
- Python 3.4 installed.
- Pip 3.4 installed.
- Volumen is /solutions/app.

Create into volumen '/solutions/app' the 'rpm' folder to put the rpm files to install in start container.
Important, add in rpm files name the numbers order to install.

Create into volumen '/solutions/app' the 'pip' folder to put the zip files to install in start container.
Important, add in zip files name the numbers order to install.

Add in docker-compose file 'PIP_PACKAGES' variable to install with pip 3.4 in start container.
Add in docker-compose file 'PYTHON_FILES' variable to execute with python 3.4 in start container.

For example, docker-compose.yml:
```
app:
 image: nfqsolutions/python:3.4-jdk7
 restart: always
 environment:
  - PACKAGES=
  - PIP_PACKAGES=
  - PYTHON_FILES=
 ports:
  - "8080:8888"
 volumes:
  - <mydirectory>:/solutions/app
  - <mydirectory>/pip:/solutions/app/pip
  - <mydirectory>/apps/rpm:/solutions/app/rpm
 
```


### License

Using this image implies accepting Oracle's [License](http://www.oracle.com/technetwork/java/javase/terms/license/index.html).
