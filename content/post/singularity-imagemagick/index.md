---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "ImageMagick"
subtitle: "Singularity recipe and image"
summary: "Singularity recipe and image for ImageMagick"
authors: ["icaoberg"]
tags: ["singularity"]
categories: ["Programming"]
date: 2020-01-12T18:00:00-00:00
featured: true
draft: true
projects: ["CMU"]

image:
  caption: "ImageMagick"
  focal_point: "Smart"
  preview_only: false
---

If you have been following my posts (and you don't have to), you probably noticed I have a lot of recipes for useful tools. I have received many questions as to why I create multiple recipes instead of a one large container with everything. 

Personally, I have my own recipe for a [Singularity container](https://github.com/icaobe
rg/singularity-basic)  with the tools I use daily. However, most of the users I support, do not have a need for an image like that. They create pipelines that use one or several tools and in turn, multiple containers. By doing this they have the flexibility to download or copyexisting image(s) from the the web or our servers without needing special permissions. It is a win-win!

Now, this is Singularity on steroids. If you are working in a small server without a scheduler (e.g. PBS, SLURM), then using aliases is the easiest way to integrate your Singularity

## Downloading the image from SyLabs.io
For simplicity, I have placed a copy of the container in [SyLabs.io](https://cloud.sylabs.io/library/_container/5e1b709c2758e9ed1175c11a). 

```
> singularity search imagemagick

No users found for 'imagemagick'

No collections found for 'imagemagick'

Found 1 containers for 'imagemagick'
	library://icaoberg/default/imagemagick
		Tags: v6.9.10-23
```

To download this image locally simply run

```
singularity pull library://icaoberg/default/imagemagick
```

### Using the Singularity image
#### Example. Resizing an image
```
> singularity run --app convert singularity-imagemagick.simg wizard.png -verbose -resize 50% wizard.png

wizard.png PNG 276x367=>138x184 138x184+0+0 8-bit sRGB 25013B 0.030u 0:00.009
```

#### Example. Convert PNG to JPG
```
> singularity run --app convert singularity-imagemagick.simg wizard.png -verbose wizard.jpg

wizard.png=>wizard.jpg PNG 138x184 138x184+0+0 8-bit sRGB 8433B 0.000u 0:00.000
```


## How make my life easier...


```
#!/bin/bash

IMAGE=singularity-imagemagick.simg
DIRECTORY=~/.singularity

if [ ! -d $DIRECTORY ]; then
	mkdir $DIRECTORY
fi

if [ ! -d $HOME/bin/imagemagick ]; then
	mkdir -p $HOME/bin/imagemagick
fi

if [ -f singularity-imagemagick.simg ]; then
	cp singularity-imagemagick.simg $DIRECTORY/
else
	bash ./build.sh
	mv singularity-imagemagick.simg $DIRECTORY/
fi

if [ -f ~/.zshrc ]; then
	SHELLRC=$HOME/.zshrc

	echo "# ImageMagick on Singularity" >> $SHELLRC
	COMMAND="alias magick='singularity run --app magick $HOME/.singularity/$IMAGE'"
	echo $COMMAND >> $SHELLRC

	COMMAND="alias animate='singularity run --app animate $HOME/.singularity/$IMAGE'"
	echo $COMMAND >> $SHELLRC

	COMMAND="alias compare='singularity run --app compare $HOME/.singularity/$IMAGE'"
	echo $COMMAND >> $SHELLRC

	COMMAND="alias composite='singularity run --app composite $HOME/.singularity/$IMAGE'"
	echo $COMMAND >> $SHELLRC

	COMMAND="alias conjure='singularity run --app conjure $HOME/.singularity/$IMAGE'"
	echo $COMMAND >> $SHELLRC

	COMMAND="alias convert='singularity run --app convert $HOME/.singularity/$IMAGE'"
	echo $COMMAND >> $SHELLRC

	COMMAND="alias display='singularity run --app display $HOME/.singularity/$IMAGE'"
	echo $COMMAND >> $SHELLRC

	COMMAND="alias mogrify='singularity run --app mogrify $HOME/.singularity/$IMAGE'"
	echo $COMMAND >> $SHELLRC

	COMMAND="alias montage='singularity run --app montage $HOME/.singularity/$IMAGE'"
	echo $COMMAND >> $SHELLRC
fi
```
