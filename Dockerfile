FROM --platform=linux/amd64 golang:1-buster
WORKDIR /
COPY secure-cli-linux-amd64 .
RUN chmod 755 secure-cli-linux-amd64
ENTRYPOINT ["./secure-cli-linux-amd64"]
