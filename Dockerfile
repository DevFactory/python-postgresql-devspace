FROM ubuntu:16.04

LABEL description="Devspaces implementation for Python with PostgreSql"

RUN apt-get update \
 && apt-get install -y ca-certificates curl git net-tools software-properties-common sudo vim wget \
 && apt-get clean \
 && add-apt-repository ppa:jonathonf/python-3.6 \
 && apt-get update \
 && apt-get install -y python python3.6 python3.6-dev python3.6-venv software-properties-common sudo vim  \
 && apt-get clean \
 && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1 \
 && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2 \
 && wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py \
 && python3 /tmp/get-pip.py \
 && pip install --user pipenv \
 && pip3 install --user pipenv \
 && echo "PATH=$HOME/.local/bin:$PATH" >> ~/.profile
 
# Installing PostgreSql 
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
 && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/PostgreSQL.list' \
 && apt-get update \
 && apt-get install -y postgresql-11 postgresql-contrib \
 && apt-get clean \
 && sed -i "s;127.0.0.1/32*;all;g" /etc/postgresql/11/main/pg_hba.conf 

ADD entrypoint.tar.gz .

RUN chmod u+x /entrypoint.sh

WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]