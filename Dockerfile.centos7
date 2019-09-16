# kraxel/s2i-jekyll
FROM centos/httpd-24-centos7

ENV RH_RUBY_VERSION="25" \
    JEKYLL_VERSION="3.8.5" \
    SUMMARY="Jekyll ${JEKYLL_VERSION}" \
    DESCRIPTION="Platform for building static jekyll sites (centos7)"

LABEL maintainer="Gerd Hoffmann <kraxel@redhat.com>" \
      summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      io.k8s.display-name="${SUMMARY}" \
      io.k8s.description="${DESCRIPTION}" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="jekyll,static"

USER root

RUN yum install -y centos-release-scl && \
    yum install -y make gcc gcc-c++ binutils \
                   glibc-devel openssl-devel \
                   rh-ruby${RH_RUBY_VERSION} \
                   rh-ruby${RH_RUBY_VERSION}-ruby-devel \
                   rh-ruby${RH_RUBY_VERSION}-rubygem-bundler && \
    yum clean all -y

RUN for file in /usr/libexec/s2i/*; do cp -v $file ${file}.httpd; done
COPY ./s2i/bin/ /usr/libexec/s2i
COPY ./etc/scl_enable /etc/
COPY ./etc/jekyll-documentroot.conf /etc/httpd/conf.d/

ENV BASH_ENV="/etc/scl_enable"

RUN source /etc/scl_enable; \
    gem install jekyll --version "= $JEKYLL_VERSION"

USER 1001
EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]
