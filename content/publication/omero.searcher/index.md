+++
title = "OMERO. searcher: content-based image search for microscope images"

# Date first published.
date = "2012-06-28"

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Cho", "Cao-Berg", "Bakal", "Murphy"]

# Publication type.
# Legend:
# 0 = Uncategorized
# 1 = Conference proceedings
# 2 = Journal
# 3 = Work in progress
# 4 = Technical report
# 5 = Book
# 6 = Book chapter
publication_types = ["2"]

# Publication name and optional abbreviated version.
publication = "In *Nature Methods*"
publication_short = "In *Nature Methods*"

# Abstract and optional shortened version.
abstract = "Fluorescence microscopy is growing dramatically both in terms of technical capabilities and the volume of images generated. Online repositories have been created to provide public access to images and opportunities for joint research for many scientists1. This has reintroduced challenges faced when sequence and structure databases were being established: developing fast and effective means of searching for records (images) either by context (such as which protein is labeled) or content (such as which pattern it displays)."

# Featured image thumbnail (optional)
image_preview = ""

# Is this a selected publication? (true/false)
selected = true

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter the filename (excluding '.md') of your project file in `content/project/`.
#   E.g. `projects = ["deep-learning"]` references `content/project/deep-learning.md`.
projects = []

# Links (optional).
url_pdf = ""
url_preprint = "https://www.nature.com/articles/nmeth.2086"
url_code = "https://github.com/ome/omero_searcher"
url_dataset = ""
url_project = ""
url_slides = ""
url_video = ""
url_poster = ""
url_source = ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
#url_custom = [{name = "MTBI", url = "https://mtbi.asu.edu/2002-8"}]

# Does the content use math formatting?
math = true

# Does the content use source code highlighting?
highlight = true

# Featured image
# Place your image in the `static/img/` folder and reference its filename below, e.g. `image = "example.jpg"`.
[header]
image = "featured.jpg"
caption = ""

+++

OMERO.searcher is an extension of the OMERO.web client that provides the ability to search for images by their content (e.g., subcellular patterns) rather than just by their annotations. It was developed by the Murphy group at Carnegie Mellon University.
OMERO.searcher:

finds images whose content, as reflected by subcellular location image features, is similar to one or more query images.

* can use positive and/or negative examples.
* can be iterative, meaning it allows the user to refine the search results (a process referred to as relevance feedback).
