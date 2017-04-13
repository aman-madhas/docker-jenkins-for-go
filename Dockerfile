FROM jenkins

# install plugins
RUN /usr/local/bin/install-plugins.sh workflow-multibranch git workflow-aggregator junit

# Update package index and install go + git

USER root

# RUN apt-get update && apt-get install -y golang-1.8-go && rm -rf /var/lib/apt/lists/*

#ENV GOLANG_VERSION 1.8.1
#ENV GOLANG_DOWNLOAD_URL https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz
#ENV GOLANG_DOWNLOAD_SHA256 a579ab19d5237e263254f1eac5352efcf1d70b9dacadb6d6bb12b0911ede8994

#RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
#	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
#	&& tar -C /usr/local -xzf golang.tar.gz \
#	&& rm golang.tar.gz

COPY go1.8.1.linux-amd64.tar.gz /usr/local/tmp/go1.8.1.linux-amd64.tar.gz 

RUN tar -C /usr/local -xzf /usr/local/tmp/go1.8.1.linux-amd64.tar.gz && rm /usr/local/tmp/go1.8.1.linux-amd64.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

RUN go version

RUN go get github.com/tebeka/go2xunit