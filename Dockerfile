FROM jenkins
# RUN /usr/local/bin/install-plugins.sh workflow-cps-global-lib:2.7 workflow-cps:2.29 workflow-durable-task-step:2.10 workflow-job:2.10 workflow-multibranch:2.14 workflow-scm-step:2.4 workflow-step-api:2.9 workflow-support:2.14 xunit:1.102 ace-editor:1.1 authentication-tokens:1.3 bouncycastle-api:2.16.1 branch-api:2.0.8 cloudbees-folder:6.0.3 credentials-binding:1.11 credentials:2.1.13 display-url-api:1.1.1 docker-commons:1.6 docker-workflow:1.10 durable-task:1.13 git-client:2.4.1 git-server:1.7 git:3.2.0 github-api:1.85 github:1.26.2 golang:1.2 handlebars:1.1.1 icon-shim:2.0.3 jquery-detached:1.2.1 junit:1.20 mailer:1.20 matrix-project:1.9 momentjs:1.1.1 pipeline-build-step:2.5 pipeline-graph-analysis:1.3 pipeline-input-step:2.5 pipeline-milestone-step:1.3.1 pipeline-model-api:1.1.2 pipeline-model-declarative-agent:1.1.1 pipeline-model-definition:1.1.2 pipeline-model-extensions:1.1.2 pipeline-rest-api:2.6 pipeline-stage-step:2.2 pipeline-stage-tags-metadata:1.1.2 pipeline-stage-view:2.6 plain-credentials:1.4 scm-api:2.1.1 script-security:1.27 ssh-credentials:1.13 structs:1.6 token-macro:2.1 workflow-aggregator:2.5 workflow-api:2.12 workflow-basic-steps:2.4

# install plugins
RUN /usr/local/bin/install-plugins.sh workflow-multibranch git workflow-aggregator junit

# Update package index and install go + git

USER root

# RUN apt-get update && apt-get install -y golang-1.8-go && rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.8.1
ENV GOLANG_DOWNLOAD_URL https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 a579ab19d5237e263254f1eac5352efcf1d70b9dacadb6d6bb12b0911ede8994

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

RUN go version

RUN go get github.com/tools/godep

RUN go get github.com/tebeka/go2xunit