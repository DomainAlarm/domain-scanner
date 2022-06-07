FROM ruby:latest
ADD . /opt/domain-scanner
RUN cd /opt/domain-scanner && bundle install