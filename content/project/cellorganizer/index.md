---
title: CellOrganizer
summary: The project provides tools for (1) learning generative models of cell organization directly from images, (2) storing and retrieving those models, (3) synthesizing cell images (or other representations) from one or more models
tags:
- pattern recognition
date: "2020-03-02T00:00:00Z"

# Optional external URL for project (replaces project detail page).
external_link: http://www.cellorganizer.org

image:
  caption: CellOrganizer
  focal_point: Smart
---

The CellOrganizer project provides tools for

* learning generative models of cell organization directly from images
* storing and retrieving those models
* synthesizing cell images (or other representations) from one or more models

Model learning captures variation among cells in a collection of images. Images used for model learning and instances synthesized from models can be two- or three-dimensional static images or movies.

CellOrganizer can learn models of

* cell shape
* nuclear shape
* vesicular organelle size, shape and position
*microtubule distribution
*average protein distributions

These models can be conditional upon each other. For example, for a given synthesized cell instance, organelle position is dependent upon the cell and nuclear shape of that instance.

Cell types for which generative models for at least some organelles have been built include human HeLa cells, mouse NIH 3T3 cells, Arabidopsis protoplasts and mouse T lymphocytes.
