FROM alpine:3.5
MAINTAINER Gervasio Marchand <gmc@gmc.uy>
ENV build_date 2017-02-27 7:52

RUN apk add --update python python-dev py2-pip build-base git supervisor redis bash && \
    pip install virtualenv && \
    rm -rf /var/cache/apk/*

RUN git clone https://github.com/g3rv4/socialvoir.git /var/socialvoir && \
    virtualenv /var/socialvoir/env && \
    /var/socialvoir/env/bin/pip install --no-cache-dir -r /var/socialvoir/requirements.txt

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME ["/var/config"]

WORKDIR /var/socialvoir
EXPOSE 8000

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
