---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "How to build your own Singularity image"
subtitle: "Singularity recipe and image"
summary: "Singularity recipe and image"
authors: ["icaoberg"]
tags: ["singularity"]
categories: ["Programming"]
date: 2019-11-13T14:00:00-00:00
lastmod: 2019-11-13T14:00:00-00:00
featured: true
draft: true
projects: []

image:
  caption: "Singularity"
  focal_point: "Smart"
  preview_only: true
---

# About this document 
The purpose of this post is to show you how to write your own Singularity recipes so that you can build and use your own Singularity containers.

This post will be long, but not extensive. I will not go into many details as to why you should use Singularity as many other resources have been written before this post.

## Vocabulary

I will be using this vocabulary through the document

* recipe. A Singularity recipe or definition file is "[...] like a set of blueprints explaining how to build a custom container." In practie, a recipe or definition file is a text file.
* container. A Singularity container is the sandbox that will hold the tool you were trying to install. In practice, a container is a binary file.

## What is Singularity?

In a nutshell, Singularity is a container solution. If you have built/used virtual machines in the past or if you are familiar with [Docker](http://www.docker.com), then you should have an idea what this means.

To summarize it, Singularity allows you to build sandboxes that you can run on a host machine. Ideally, these sandboxes will have one or several pieces of software that you wish to use.

There are many reasons as to why you would use Singularity, but in my experience as a power user and cluster manager I think the most important are

1. As a poweruser, do not have permission to install software on the system you want to perform your calculations. Alternatively, installing libraries or specific software in your home directory can be time consuming especially if you do not know what do/are doing.
2. The software you wish to install is either too outdated or too recent and the installation of said piece of technology is impossible, difficult or just takes too much time.
3. You have access to a cluster that doesn't support Docker, VirtualBox or VMWare among many others.

That being said, if you would like more general information about Singularity, I suggest you start with the [FAQ](https://sylabs.io/singularity/faq/).

If you would like a more technical explanation, I suggest you also visit the Singularity 101 [tutorial](https://github.com/ArangoGutierrez/Singularity-tutorial) written by [Eduardo Arango](https://github.com/ArangoGutierrez).

## Why should I use Singularity?
If you read the FAQ you will find many reasons as to why you should use this technology. In this post I will only focus on a subset of these reasons.

### Ok, hear me out...

| ![Confusion](./confused.jpg) |
| :--: | 
| It is Friday night and I need to install a new version of GCC on the lab server but I don't have root access. What do I do? |

Please consider this scenario: you are a researcher or undergrad/grad student at a university or research institute. You may have

* have an old laptop or a good laptop but not powerful enough to get you results in a reasonable amount of time.
* access to a large server or computing resource through a research lab.
* access to an [HPC](https://en.wikipedia.org/wiki/Supercomputer) cluster through a department, school or institution.

In any case, you are not the [administrator](https://en.wikipedia.org/wiki/Superuser) (nor you will ever be). So, how do you get the software you need to run on these machines without bothering the ever so grouchy cluster manager? **Singularity!**

| ![Success](./success.jpg) |
| :--: |
| I can build a Singularity container with GCC or download it from www.sylabs.io and upload it to the lab server. Success! |

To me, the best reasons of using Singularity are

* Time efficiency. You have the freedom to build your own container and upload the image to use it on a server or large resource that uses Singularity.
* Simplicity. It is easier to build a simple container than it is to install software on a larger system. Not always true, but believe true most of the times.

## Ok, I bought it, where can I get these recipes?
All over the place. Since Singularity was built to cater the open-source community (though it can be used with propietary software), there are many repositories out there with the recipes to build containers. There is no need to reinvent the wheel. However sometimes you will need to build these from scratch.

For example, in this [repository](https://github.com/icaoberg/singularity-gdc-client) you can find the file Singularity, which is the recipe to build a container with the GDC client.

## So a recipe is the same thing as a container?
No. The recipe contains the instructions to build the container. A container is an actual file that contains the necessary libraries or dependencies to run a specific software.

You can build your own container, or if you trust another builder, you can download containers from the web. Alternatively you can ask your cluster manager or administrator to build one for you.

For example, in this [container repository](https://cloud.sylabs.io/library/_container/5da29e58c9435e18ec55fac3) you can find a copy of the container built from the Singularity recipe in the previous question.

## Wait... what about Docker?

Both [Docker](https://www.docker.com/) and Singularity are container solution technologies, however they serve different purposes.

If you are familiar with both, then you probably know there are situations where one is better than the other. However for the purpose of this post, we will focus on the benefits of Singularity without mentioning Docker (not really, I will mention it quite a few times).

# Let's get our hands dirty

Considering the scenario above, what is common, at least in my experience, is that a researcher may have access to an office desktop/laptop, a large server and -hopefully- an HPC cluster like [Bridges](https://www.psc.edu/bridges). The researcher may write a script and will test it locally. Then the researcher will upload the script and data to a larger resource for computation.

**Does this sound familiar?**

Now this is where Singularity comes in handy. You have total control of your local machine but not on the larger resource. However, you want the correct versions of each library or packages so that your results are reproducible and reliable. Matching versions of specific libraries is often desirable.

| ![Idea](./idea.jpg) |
| :--: |
| In an ideal scenario you would want to run the container in both your local machine and the larger resource. However, that is not always the case. Most times you will be running the container only on the larger resource |

# Before we begin
## Install Singularity

The first step is to install Singularity on your local machine and the large resource. If Singularity is already installed in the large resource, then I would recommend you install the same Singularity version locally.

Installing Singularity is beyond the scope of this document. To install Singularity please refer to the [official documentation](https://sylabs.io/docs/).

## Other requesites
None for this post.

For clarification, my server and local machine is running Ubuntu 18.04. You can install Singularity on MacOSX and Windows. However it requires some extra steps to make them work on either system, something that is beyond the scope of this document.

## Creating an Ubuntu 16.04 container
Let's start with a simple recipe. I will use this empty container (empty as in it doesn't have a tool of interest) for the rest of this post. In file called `Singularity` I am going to add the lines below

{{< highlight bash >}}
Bootstrap: docker
From: ubuntu:16.04

IncludeCmd: yes
{{< / highlight >}}

This basic recipe is stating that I want to pull an Ubuntu 16.04 Docker container and create a Singularity container.

To create the Singularity image I ran the commands

{{< highlight bash >}}
IMAGE_NAME=singularity-latex.simg
DEFINITION=Singularity

sudo singularity build $IMAGE_NAME $DEFINITION
{{< / highlight >}}

will lead to the following output

{{< highlight bash >}}
INFO:    Starting build...
Getting image source signatures
Skipping fetch of repeat blob sha256:e80174c8b43b97abb6bf8901cc5dade4897f16eb53b12674bef1eae6ae847451
Skipping fetch of repeat blob sha256:d1072db285cc5eb2f3415891381631501b3ad9b1a10da20ca2e932d7d8799988
Skipping fetch of repeat blob sha256:858453671e6769806e0374869acce1d9e5d97f5020f86139e0862c7ada6da621
Skipping fetch of repeat blob sha256:3d07b1124f982f6c5da7f1b85a0a12f9574d6ce7e8a84160cda939e5b3a1faad
Copying config sha256:857090aeed08b5205381496f26d1eea9426a34ed441dbed218d257948242307a
 2.42 KiB / 2.42 KiB [======================================================] 0s
Writing manifest to image destination
Storing signatures
2019/11/14 13:12:29  info unpack layer: sha256:e80174c8b43b97abb6bf8901cc5dade4897f16eb53b12674bef1eae6ae847451
2019/11/14 13:12:30  info unpack layer: sha256:d1072db285cc5eb2f3415891381631501b3ad9b1a10da20ca2e932d7d8799988
2019/11/14 13:12:30  info unpack layer: sha256:858453671e6769806e0374869acce1d9e5d97f5020f86139e0862c7ada6da621
2019/11/14 13:12:30  info unpack layer: sha256:3d07b1124f982f6c5da7f1b85a0a12f9574d6ce7e8a84160cda939e5b3a1faad
INFO:    Creating SIF file...
INFO:    Build complete: singularity-latex.simg
{{< / highlight >}}


## Building your own container

{{< highlight bash >}}
Bootstrap: docker
From: ubuntu:16.04

IncludeCmd: yes

%labels
  Maintainer icaoberg AT alumni DOT cmu DOT edu
  Version v1.0

%post
    /usr/bin/apt-get update && /usr/bin/apt-get -y upgrade
    /usr/bin/apt-get -y install module-init-tools
    /usr/bin/apt-get update --fix-missing
    /usr/bin/apt-get install -y --no-install-recommends apt-utils build-essential
{{< / highlight >}}
