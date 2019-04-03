# DevSpace for Python development with PostgreSQL

* Python v3.6.7
* pip v19.0.3
* PostgreSQL v11.2

## Getting Started

1. First install DevSpaces client application, follow the instructions [here](https://support.devspaces.io/article/22-devspaces-client-installation) to do this.

2. Clone this repository locally

3. To create a DevSpace, open a terminal then navigate to the cloned repository directory and run following command
```bash
devspaces create
```
This will open a build status window and shows you the progress of DevSpace creation. Once build is successful validated starts.

4. Once validation is completed. Run `devspaces ls` command to see the list of DevSpaces and corresponding status. Newly created DevSpace `python-postgres` will be in "**Stopped**" status.

5. To start your DevSpace run following command
```bash
devspaces start python-postgres
```
You will receive a notification when your DevSpace is ready to be used.

6. To get inside your DevSpace, run following command
```bash
devspaces exec python-postgres
```

## Run Demo Django Application

1. From a new terminal, clone the demo application repository
```bash
git clone https://github.com/JumboCode/django-postgres-tutorial.git
```

2. Navigate to cloned demo application directory
```bash
cd django-postgres-tutorial
```

3. To synchronization code from your local machine to your DevSpace. Run following command
```bash
devspaces bind python-postgres
```
This will synchronize files from your current working directory to your DevSpace. It might takes some time to complete, depending on the repository size.

4. Get inside your DevSpace by running following command
```bash
devspaces exec python-postgres
```
5. Once you're inside DevSpace, you should be able see `django-postgres-tutorial` project files under `/data` directory.

6. Install dependencies
```bash
pip install -r requirements.txt
```

7. Prepare database
```bash
su postgres
psql
CREATE DATABASE djangotutorial;
CREATE USER djangotutorial WITH PASSWORD 'supersecret';
GRANT ALL PRIVILEGES ON DATABASE "djangotutorial" to djangotutorial;
\q
exit
```

7. export ENV variable.
```bash
export DJANGO_SETTINGS_MODULE=django_postgres_example.settings.dev
```

8. Run migrations
```bash
python3 manage.py makemigrations
python3 manage.py migrate
```

9. Add `.devspaces.io` to `ALLOWED_HOSTS` variable in `django_postgres_example/settings/dev.py`. This can be done from your local machine as well and change will be synchronized to DevSpace. After change it looks like this
```python
ALLOWED_HOSTS = ['localhost', '.devspaces.io']
```

10. Run the demo project
```bash
python3 manage.py runserver 0.0.0.0:80
```

Now run following command from your local terminal `devspaces info python-postgres`. URL under URLs section is the public URL to your running application. Append `api/sleds/` to the URL to see it is working e.g. `http://python-postgres.<username>.devspaces.io:<port>/api/sleds/`
