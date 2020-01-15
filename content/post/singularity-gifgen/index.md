---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "gifgen"
subtitle: "Singularity recipe and image"
summary: "Singularity recipe and image for gifgen"
authors: ["icaoberg"]
tags: ["singularity"]
categories: ["Programming"]
date: 2020-01-14T08:00:00-00:00
featured: true
draft: false
projects: ["CMU"]

image:
  caption: "gifgen"
  focal_point: "Smart"
  preview_only: true
---

[![Joaquin Sabina](./sabina.gif)](https://www.youtube.com/watch?v=NY_EOhHRTdo)

[gifgen](https://github.com/lukechilds/gifgen) provides simple high quality GIF encoding.

## Source code
You can find the recipe to build the container [here](https://github.com/icaoberg/singularity-gifgen).

### Building the image locally

The script `build.sh` looks like

```
#!/bin/bash

IMAGE=singularity-gifgen.simg
DEFINITION=Singularity

if [ -f $IMAGE ]; then
	rm -fv $IMAGE
fi

sudo singularity build $IMAGE $DEFINITION
```

To build the image locally simply run

```
bash ./build.sh
```

### Building the image remotely

The script `rbuild.sh` looks like

```
#!/bin/bash

IMAGE=singularity-gifgen.simg
DEFINITION=Singularity

if [ -f $IMAGE ]; then
	rm -fv $IMAGE
fi

singularity build --remote $IMAGE $DEFINITION
```

If you notice, there isn't much difference between this script and the previous script.

To build the image remotely simply run

```
bash ./rbuild.sh
```

## Running gifgen

To run the app in the container, simply run

```
singularity exec singularity-gifgen.simg gifgen
```
