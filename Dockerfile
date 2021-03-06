FROM cmfatih/phantomjs
MAINTAINER binux <roy@binux.me>

# install python
RUN apt-get update && \
        apt-get install -y python python-dev python-distribute python-pip && \
        apt-get install -y libcurl4-openssl-dev libxml2-dev libxslt1-dev python-lxml python-mysqldb libpq-dev

# install requirements
RUN pip install -U pip setuptools
RUN pip install --egg http://cdn.mysql.com//Downloads/Connector-Python/mysql-connector-python-2.1.5.zip#md5=ce4a24cb1746c1c8f6189a97087f21c1
ADD requirements.txt /opt/pyspider/requirements.txt
RUN pip install -r /opt/pyspider/requirements.txt

# add all repo
ADD ./ /opt/pyspider

# run test
WORKDIR /opt/pyspider
RUN pip install -e .[all]

VOLUME ["/opt/pyspider"]
ENTRYPOINT ["pyspider"]

EXPOSE 5000 23333 24444 25555
