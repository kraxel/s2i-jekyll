# kraxel/s2i-jekyll
FROM openshift/base-centos7

LABEL maintainer="Gerd Hoffmann <kraxel@redhat.com>"

ENV RH_RUBY_VERSION="25" \
    JEKYLL_VERSION="3.8.5"

LABEL io.k8s.description="Platform for building static jekyll sites" \
      io.k8s.display-name="Jekyll ${JEKYLL_VERSION}" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="jekyll,static"

RUN yum install -y centos-release-scl && \
    yum install -y httpd \
                   rh-ruby${RH_RUBY_VERSION} \
                   rh-ruby${RH_RUBY_VERSION}-ruby-devel \
                   rh-ruby${RH_RUBY_VERSION}-rubygem-bundler && \
    yum clean all -y

ENV BASH_ENV="/opt/rh/rh-ruby${RH_RUBY_VERSION}/enable"

RUN source /opt/rh/rh-ruby${RH_RUBY_VERSION}/enable; \
    gem install jekyll --version "= $JEKYLL_VERSION"

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root
RUN chown -R 1001:1001 /var/www/html
RUN echo "Listen 8080" > /etc/httpd/conf.d/port-8080.conf

USER 1001
EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]
