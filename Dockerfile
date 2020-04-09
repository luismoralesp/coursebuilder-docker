FROM google/cloud-sdk:alpine

ADD coursebuilder coursebuilder

WORKDIR /coursebuilder

RUN gcloud components install app-engine-python-extras app-engine-python

# Install build essentials
RUN apk update && apk add alpine-sdk libxml2-dev libxslt-dev openjdk7-jre python2 py-pip python-dev libffi-dev openssl-dev

RUN pip install -U setuptools

RUN bash ./scripts/common.sh

ENV CLOUDSDK_PYTHON python2
ENV GCB_DIR /var/google/course-builder
ENV GCB_PRODUCT_VERSION '1.11.001'
ENV GCB_APPSTATS_ENABLED 'false'
ENV GCB_TEST_MODE 'false'
ENV GCB_PRELOADED_MODULES 'modules.help_urls.help_urls\nmodules.dashboard.dashboard'


EXPOSE 8080
EXPOSE 8000

# CMD ["python", "-m", "SimpleHTTPServer"]
# CMD ["bash", "./scripts/deploy.sh", "elish"]