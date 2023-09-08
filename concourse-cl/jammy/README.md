Running

You have to bring your source code; the container will attempt to run the /u/boot.lisp file to get it started.

docker run -it \
           -v ~/code/my-cl-thing:/u \
           huntprod/cl


docker pull genesiscommunity/concourse-go:1.20-ubuntu-jammy
