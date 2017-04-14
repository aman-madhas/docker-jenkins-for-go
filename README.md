# docker-jenkins-for-go
Docker image based on Jenkins for Golang projects

This project builds a docker image to support building/testing of golang projects source controlled in git-based repository.  Jenkins pipeline should be defined in your project Jenkinfile.  Using multi-branch approach.

Docker image is based on https://hub.docker.com/_/jenkins/

Jenkins plugins installed are:
-workflow-multibranch
-git
-workflow-aggregator
-junit

go1.8.1 source is downloaded and compiled for linux-amd64 alpine, see https://hub.docker.com/_/golang/ 

Uses go2xunit (https://github.com/tebeka/go2xunit) to convert go test results into Jenkins-viewable junit results

# To build the docker image:
docker build -t aman/jenkinsgo .

# To run docker container (volume specified for windows):
docker run --name jenkinsgo -p 8080:8080 -p 50000:50000 -v //c/Users/IBM_ADMIN/sandbox/docker-volumes/jenkinsgo:/var/jenkins_home aman/jenkinsgo

You'll see the initial admin password in the logs, copy it.
Log into Jenkins in browser:
http://192.168.99.100:8080/

Enter the initial admin password.
I recommend creating a new user.
Create a new multibranch project
Enter your repo details
Build will be triggered by commits on a branch assuming you have committed a valid Jenkinsfile in the project root directory.

# To inspect your container
docker exec -i -t jenkinsgo /bin/sh