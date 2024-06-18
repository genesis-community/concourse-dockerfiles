
genesiscommunity/concourse-cl:ubuntu-jammy
==============================

Task Image for running Concourse Pipelines - Common Lisp

This Docker image contains a set of utilities commonly used in
Concourse pipelines, pre-installed, along with Steel Bank Common Lisp
installation.  The version installed is the latest version that apt-get
retrieves when the image is built.

By default the image will execute a lisp code stored in the file
/u/boot.lisp.

docker run -it \
           -v ~/code/my-lisp-code-directory:/u \
           genesiscommunity/concourse-cl:ubuntu-jammy

