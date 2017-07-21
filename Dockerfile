FROM xataz/alpine:3.6

LABEL description="Shinken based on alpine" \
      tags="latest 2.4.3 2.4 2" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017072101"

ENV UID=1000 \
    GID=1000 \
    TZ=Europe/Paris

ARG SHINKEN_VER=2.4.3
ARG SHINKEN_CUSTOM_MODULES=""
ARG CUSTOM_PACKAGES=""
ARG CUSTOM_BUILD_PACKAGES=""
ARG CUSTOM_PYTHON_PACKAGES=""
ARG MONITORING_PLUGINS_VER="2.2"

RUN BUILD_DEPS="build-base \
                python2-dev \
                linux-headers \
                py2-pip \
                curl-dev \
                libressl-dev \
                libffi-dev \
                g++ \
                gcc \
                make \
                perl-dev \
                ${CUSTOM_BUILD_PACKAGES}" \
    && SHINKEN_MODULES="webui2 \
                        auth-htpasswd \
                        booster-nrpe \
                        auth-cfg-password \
                        ui-graphite2 \
                        graphite2 \
                        simple-log \
                        pickle-retention-file-generic" \
    && apk add --no-cache ${BUILD_DEPS} \
                            python2 \
                            su-exec \
                            tini \
                            curl \
                            libressl \
                            ca-certificates \
                            nagios-plugins-all \
                            nrpe \
                            nrpe-plugin \
                            bash \
                            shadow \
                            openssh \
                            cairo \
                            fontconfig \
                            tzdata \
                            py-setuptools \
                            nginx \
                            iputils \
                            perl \
                            libgcc \
                            mongodb \
                            inotify-tools \
                            supervisor \
                            ${CUSTOM_PACKAGES} \
    && adduser -h /home/shinken -u 1000 -g 1000 -D shinken \
    && pip install cffi \
    && pip install pycurl \
                    shinken==${SHINKEN_VER} \
                    pymongo \
                    requests \
                    arrow \
                    bottle==0.12.8 \
                    passlib \
                    alignak_backend_client \
                    paramiko \
                    cherrypy==3.5.0 \
                    graphite-web \
                    whisper \
                    carbon \
                    scandir \
                    gunicorn \
                    flup \
                    ${CUSTOM_PYTHON_PACKAGES} \
    && su - shinken -c 'shinken --init' \
    && wget https://www.monitoring-plugins.org/download/monitoring-plugins-${MONITORING_PLUGINS_VER}.tar.gz -O /tmp/monitoring-plugins-${MONITORING_PLUGINS_VER}.tar.gz \
    && tar -xvf /tmp/monitoring-plugins-${MONITORING_PLUGINS_VER}.tar.gz -C /tmp \
    && cd /tmp/monitoring-plugins-${MONITORING_PLUGINS_VER}/ \
    && ./configure --with-nagios-user=shinken --with-nagios-group=shinken --enable-libtap --enable-extra-opts --enable-perl-modules --libexecdir=/var/lib/shinken/libexec \
    && make install \
    && for module in ${SHINKEN_MODULES} ${SHINKEN_CUSTOM_MODULES}; do su - shinken -c "shinken install ${module}"; done \
    && apk del --no-cache ${BUILD_DEPS} \
    && rm -rf /tmp/* /usr/bin/mongoperf

COPY rootfs /
RUN chmod u+x /usr/local/bin/startup

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
