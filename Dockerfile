FROM ubuntu:17.10

RUN apt-get update \
    && apt-get install -y webhook nomad

COPY hooks /hooks

EXPOSE 9000
CMD ["webhook", "-hooks", "/hooks/hooks.json", "-verbose"]
