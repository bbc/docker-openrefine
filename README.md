docker-openrefine
=================

A Dockerfile setting up OpenRefine 2.5 with v0.8.0 of the DERI [RDF extension][1]. This is a stable configuration that works; later versions of OpenRefine do are not supported by the RDF extension.

Usage
-----

Build:

    docker build -t openrefine .

Run (and show on port 80)

    docker run -p 80:3333 openrefine

If you want refine projects to be persistent, you must mount `/mnt/refine` as follows:

    docker run -p 80:3333 -v /path-to-host:/mnt/refine openrefine

You can also increase the max size of the heap, by specifying the REFINE_MEMORY environment variable:

    docker run -p 80:3333 -e REFINE_MEMORY=24G openrefine

Proxies
-------

This repository has hardcoded proxy config for usage inside the BBC R&D LAN. Remove the line beginning `ENV http_proxy...` to remedy this. Searching for a neater solution...

Credit
------

This is a modified fork of https://www.github.com/spaziodati/grefine-rdf-extension. PRs, tips, etc appreciated!

[1]: https://github.com/fadmaa/grefine-rdf-extension
[2]: https://github.com/giTorto/Refine-NER-Extension
[3]: https://github.com/giTorto/geoXtension
[4]: https://github.com/giTorto/extraCTU-plugin
[5]: https://registry.hub.docker.com/u/spaziodati/openrefine/
