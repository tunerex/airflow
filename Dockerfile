FROM docker-dev.ops.tune.com/itops/baseimages-centos7:latest
MAINTAINER Rex Kim "rex@tune.com"

ENV AIRFLOW_VERSION 1.6.2
ENV AIRFLOW_HOME /usr/local/airflow

# Define en_US.
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm

RUN yum -y update && \
    yum -y install \
        python-pandas \
        gcc-gfortran \
        numpy \
        python-pip \
        python-wheel \
        python-setuptools \
        svn \
        gcc \
        gcc-c++ \
        mysql-devel \
        locales

RUN mkdir -p /wheels
ADD ./dist /wheels

RUN  pip install mysql-python \
    && pip install /wheels/airflow-${AIRFLOW_VERSION}-py2.py3-none-any.whl \
    && pip install boto

RUN mkdir -p ${AIRFLOW_HOME}

EXPOSE 8080 5555 8793

WORKDIR ${AIRFLOW_HOME}
