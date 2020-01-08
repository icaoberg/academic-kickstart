---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Singularity and Travis config"
subtitle: "Updating my Travis config files"
summary: "Updating my Travis config files"
authors: ["icaoberg"]
tags: ["singularity", "travis-ci"]
categories: ["Programming"]
date: 2020-01-07T16:00:00-00:00
featured: true
draft: false
projects: ["CMU"]

image:
  caption: "Logo"
  focal_point: "Smart"
  preview_only: true
---

If you read my previous post, I updated a repository I built a while ago with a Singularity recipe for gotop. The main reason for the post was to show how easy it is to build a simple small container both locally and remotely.

<iframe src="https://giphy.com/embed/XR9Dp54ZC4dji" width="480" height="288" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><br>**Figure 1**. Surprised, it works pretty easily.

However because my original repository was built a while ago, I built my original container on Singularity v2.6.0 while the latest is Singularity v3.5.2. Hence, I needed to update my scripts. And you know, it wasn't that difficult and it worked. 

But then.... Travis.

## Travis, my old enemy

![Logo](./logo.png)

"Travis CI is a hosted continuous integration service used to build and test software projects hosted at GitHub." [[Wikipedia](https://en.wikipedia.org/wiki/Travis_CI)]. It was comforting to find Singularity Hub has a template I could reuse. To see their repo click [here](https://github.com/singularityhub/travis-ci).

Hence, I needed to update my Travis config file as well. It wasn't easy. Installing the newer version of Singularity was a little more convoluted than the older versions (though not that much). Now, the Travis config for [gotop](https://github.com/icaoberg/singularity-gotop) looks like this

```
os: linux

# whitelist
branches:
  only:
    - master

language: go

go:
    - "1.13"

python:
    - "3.7"

addons:
  apt:
    packages:
      - flawfinder
      - squashfs-tools
      - uuid-dev
      - libuuid1
      - libffi-dev
      - libssl-dev
      - libssl1.0.0
      - libarchive-dev
      - libgpgme11-dev
      - libseccomp-dev
  homebrew:
    packages:
      - squashfs
    update: true

sudo: required
#dist: trusty

matrix:
  include:
    - python: "2.6"
    - python: "3.5"

before_install:
  - sudo chmod u+x .travis/*.sh
  - /bin/bash .travis/setup.sh

install:
  - # override

script:
  - bash ./build.sh
  - du -h singularity-gotop.simg
```

and the `./.travis/setup.sh` is just as straight-forward

```
#!/bin/bash -ex

sudo sed -i -e 's/^Defaults\tsecure_path.*$//' /etc/sudoers

pip install --user sregistry[all]

# Install Singularity
SINGULARITY_BASE="${GOPATH}/src/github.com/sylabs/singularity"
export PATH="${GOPATH}/bin:${PATH}"

mkdir -p "${GOPATH}/src/github.com/sylabs"
cd "${GOPATH}/src/github.com/sylabs"

git clone https://github.com/sylabs/singularity
git checkout tags/v3.5.2
cd singularity
./mconfig -v -p /usr/local
make -j `nproc 2>/dev/null || echo 1` -C ./builddir all
sudo make -C ./builddir install
```

The script above is a cleaned up version of the script suggested by the Singularity Hub repo. [It works!](https://travis-ci.org/icaoberg/singularity-gotop/builds/633977539) So I am a happy camper.

<iframe src="https://giphy.com/embed/pGOLBwYBTEvsI" width="480" height="357" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><br>**Figure 2**. I am a happy camper.
