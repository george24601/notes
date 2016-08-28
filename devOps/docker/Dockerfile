#base image
FROM docker/whalesay:latest

MAINTAINER Kate Smith <ksmith@example.com>

#install program
RUN apt-get -y update && apt-get install -y fortunes

#software to run when the image is loaded
CMD /usr/games/fortune -a | cowsay
