---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "cowsay"
subtitle: "Singularity recipe and image"
summary: "Singularity recipe and image for browsh"
authors: ["icaoberg"]
tags: ["singularity", "twitter"]
categories: ["Programming"]
date: 2020-02-26T10:00:00-00:00
featured: true
draft: false
projects: []

image:
  caption: "browsh"
  focal_point: "Smart"
  preview_only: true
---

{{< twitter 1232811924204724224 >}}

Working with [environment modules](http://modules.sourceforge.net/) makes my life so much easier.

For example, for `cowsay`,I created a `modulefile` that will load the Singularity container to workspace along with a script that calls it. Making the process transparent to the user.

To make this work you need three things

* an executable script that calls singularity (avoid using `alias`)
* the Singularity container file
* a modulefile

The `modulefile` file I created for `cowsay` is the following

```
#%Module
##
## cowsay modulefile
##
## modulefiles/
##

set ver 3.03

set msg "This module adds cowsay $ver to various paths\n"

proc ModulesHelp { } {
        puts stderr $msg
}

module-whatis "Use cowsay tools $ver"

prepend-path PATH /path/to/containers/cowsay/v3.03/
```

The `modulefile` itself is very straightforward, all it does is prepend a folder. Now the folder its prepending has two files

* the Singularity image
* an executable script that calls the image

In my system, there exists a folder with the following files

```
[icaoberg] $ ls -lt
total 68899
-rwxr-xr-x 1 root root 70799360 Feb 26 17:48 singularity-debian-buster-cowsay-v3.03.simg
-rwxr-xr-x 1 root root      366 Feb 26 17:48 cowsay
```

The contents of `cowsay` (the script I built, not the actual binary) are

```
#!/bin/bash

IMAGE=singularity-debian-buster-cowsay-v3.03.simg

function is_compute_node(){
if [ -x "$(command -v singularity)" ]; then
	return 0
else
	return 1
fi
}

if is_compute_node; then
	singularity run --app cowsay $(pwd)/$IMAGE "$1"
else
	echo "Singularity apps cannot run in the head node. Please request an allocation or call Singularity within a job."
fi
```

Now, in my case the function

```
function is_compute_node(){
if [ -x "$(command -v singularity)" ]; then
        return 0
else
        return 1
fi
}
```

is neccesary because the `singularity` binary is not accesible from the head node of our HPC cluster. Users must request an allocation to a compute node in order to run apps in Singularity containers.

In a nutshell, you can load and use `cowsay` like this

I hope you found this post useful.

* [GitHub source code repository](https://github.com/icaoberg/singularity-cowsay)
* [SyLabs.io Cloud image repository](https://cloud.sylabs.io/library/icaoberg/default/cowsay)
