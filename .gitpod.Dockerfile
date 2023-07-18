FROM gitpod/workspace-full:2023-05-08-21-16-55

ENV SPARK_HOME=/opt/spark
ENV SPARK_LOCAL_IP=127.0.0.1

ENV LIVY_HOME=/opt/livy

USER root

# Apache Spark
RUN cd /tmp \
    && curl -sSL -O https://dlcdn.apache.org/spark/spark-3.2.4/spark-3.2.4-bin-hadoop3.2.tgz \
    && tar -zxf spark-3.2.4-bin-hadoop3.2.tgz -C /opt \
    && cd /opt \
    && ln -s spark-3.2.4-bin-hadoop3.2 spark \
    && rm /tmp/spark-*.tgz

# MinIO server and mc client 
RUN wget \
    # Install minio server 
    https://dl.min.io/server/minio/release/linux-amd64/minio \
    && chmod +x minio \
    && mv minio /usr/local/bin/ \
    # Install minio client
    && wget https://dl.min.io/client/mc/release/linux-amd64/mc \
    && chmod +x mc \
    && mv mc /usr/local/bin 

# Apache Livy 
RUN cd /tmp \
    # Download custom build livy archives form fork repository
    && wget https://github.com/kachontep/incubator-livy/releases/download/v0.8.0-incubating-c3dd645/apache-livy-0.8.0-incubating-c3dd645_2.12-bin.zip \
    && unzip -d /opt/ apache-livy-0.8.0-incubating-c3dd645_2.12-bin.zip \
    && mv /opt/apache-livy-0.8.0-incubating-SNAPSHOT_2.12-bin /opt/livy-0.8.0-incubating-c3dd645_2.12-bin \
    # Install livy and environment 
    && cd /opt && ln -s livy-0.8.0-incubating-c3dd645_2.12-bin livy \
    && mkdir -p /opt/livy/logs \
    && chmod 777 /opt/livy/logs \
    && rm /tmp/apache-livy* 

 # Install MySQL
RUN install-packages mysql-server \
 && mkdir -p /var/run/mysqld /var/log/mysql \
 && chown -R gitpod:gitpod /etc/mysql /var/run/mysqld /var/log/mysql /var/lib/mysql /var/lib/mysql-files /var/lib/mysql-keyring /var/lib/mysql-upgrade

# Install our own MySQL config
COPY docker/mysql/mysql.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# Install default-login for MySQL clients
COPY docker/mysql/client.cnf /etc/mysql/mysql.conf.d/client.cnf

COPY docker/mysql/mysql-bashrc-launch.sh /etc/mysql/mysql-bashrc-launch.sh


USER gitpod

# Python 3.10.9 
RUN pyenv install 3.10.9 \
    && pyenv global 3.10.9 \
    && pyenv uninstall -f 3.11.1 \
    && python3 -m pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir --upgrade \
    setuptools wheel virtualenv pipenv pylint rope flake8 \
    mypy autopep8 pep8 pylama pydocstyle bandit notebook \
    twine

# SparkMagic 
RUN python -m pip install sparkmagic \
    && jupyter nbextension enable --py --sys-prefix widgetsnbextension \
    && jupyter-kernelspec install --user $(python -m pip show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/pysparkkernel
