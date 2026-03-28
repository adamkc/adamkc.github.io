---
published: TRUE
layout: post
title: A Browser Trail Editor
---

The Google Earth - QGIS - Google Earth loop for trail design can be time consuming and may not find the ideal route. Draw a route, export it, calculate grades based on LiDAR elevations, find out half the segments are too steep, go back, redraw, re-export. Repeat.

So I built a thing. It loads a DEM, generates hillshade and contours, and lets you drag trail vertices around while the elevation and slope profiles update live. No install, no server, everything runs in the browser.

![Trail Route Editor](/images/trail-editor.png)

## What you can do with it

-   Load a GeoTIFF and get hillshade, contour lines, and 3D terrain
-   Import routes as GeoJSON or KML, or click out a new one on the map
-   Drag vertices and watch the grade change in real time
-   Run a route optimizer that tries to hit a target grade
-   Flag drainage problems where the trail follows the fall line too long
-   Export the result as GeoJSON or KML
-   And possibly my favorite part, use a right-click to rotate the map and see the trail network in 3d

## The optimizer

This part was the most challenging to develop and could probably benefit from additional trial and error. It's a spring-mass simulation where each vertex is a particle connected to its neighbors. Forces nudge the trail toward a target elevation while springs keep things smooth and stop the trail from crossing itself. You can freeze vertices on road sections so the optimizer leaves them alone.

There's a second pass that goes after individual steep segments. The first pass gets the overall grade right; the second pass cleans up the worst spots. It works, mostly. Sometimes it does something weird and you have to freeze a section and run it again. Trail design on actual terrain turns out to be a hard optimization problem.

Freezing individual nodes can be very powerful if you've got location that the trail must hit, or a section that it shouldn't deviate from (like where the trail follows an existing road). Another use of freezing nodes it to control where the optimizer places slopes. For example if you have a trail that is 3% grade for the first half and 10% grade for the second half, freezing a node at that inflection point allows the model to calculate optimal elevations for each segment, rather than trying to average the total elevation change across the full segment, it'll build a low slope segment and a high slope segment.

## Try it

It's at [adamkc.github.io/trail-route-editor](https://adamkc.github.io/trail-route-editor/). You need a GeoTIFF DEM and a trail file. Everything stays on your machine.

Source is on [GitHub](https://github.com/adamkc/trail-route-editor). There's also a local Python server if you want GeoPackage support. Download the Repo and run locally.
