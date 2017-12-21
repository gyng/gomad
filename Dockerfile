FROM ubuntu:17.10

RUN apt-get update \
    && apt-get install -y webhook curl bsdtar
RUN curl -L https://releases.hashicorp.com/nomad/0.7.1/nomad_0.7.1_linux_amd64.zip \
    | bsdtar -xvf - -C /usr/local/bin \
    && chmod +x /usr/local/bin/nomad

COPY hooks /hooks

EXPOSE 9000
CMD ["webhook", "-hooks", "/hooks/hooks.json", "-verbose"]
