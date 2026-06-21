---
published: true
layout: post
title: Finding lost meadows
---

A meadow is mostly a story about water and dirt. Where a mountain valley flattens out, water slows down, fine sediment settles, and the water table sits high enough to favor grasses and sedges over conifers. That geometry is the meadow. The plants are just what grows on top of it.

That distinction turns out to matter, because the plants can leave while the geometry stays. Over the last 150 years, grazing, roads, ditching, and a century of fire suppression dropped a lot of meadow water tables, and trees and brush moved in. From the air those places stop looking like meadows. But the low-gradient valley floor that made them meadows in the first place is still sitting there.

So a few years ago we went looking for them. The idea, from [our 2023 paper in *Landscape Ecology*](https://link.springer.com/article/10.1007/s10980-023-01726-7) ([pdf](/docs/pdfs/cummings2023.pdf)), was to learn the part of a meadow that doesn't disappear: its shape. We took about 11,000 mapped meadows across 25,300 km² of the Sierra Nevada and trained a random forest to recognize the hydrogeomorphic signature of meadow ground (topographic position, flow accumulation, snowpack, and relief measured at several scales) while ignoring vegetation entirely. Then we ran the model over the rest of the landscape and asked where else the terrain looked the same.

It flagged nearly three times more meadow-shaped ground than is currently mapped. Some of that is meadow we've already lost. Some of it may never have grown the right plants. The model can't tell those two apart; it only knows the shape is right.

## The map

The predictions aren't much use sitting in a folder, so they're on a map you can click:

<iframe src="https://adamcummings.net/lost-meadows-map/" title="Lost Meadows Predictions map" style="border: 1px solid #ddd; width: 100%; height: 600px;" loading="lazy"></iframe>

[Open the full map](https://adamcummings.net/lost-meadows-map/)

Pick a HUC10 watershed and you can download its prediction files: high-confidence polygons, medium-confidence polygons, and the raster they came from. Everything lives on Google Drive, split by watershed, so you can grab one basin without pulling down the whole Sierra.

A couple of things worth knowing before you use them. High confidence means the model is fairly sure the terrain is meadow-like; medium confidence is more of a "worth a look." And the model learned what a meadow is from the Sierra Nevada, so the farther you get from that training ground, the more skeptically you should read it.

Mostly, though, a prediction is a hypothesis, not a meadow. It's a spot on the map saying the ground here has the right bones. Whether there's anything left to restore is a question you answer by going there.

## Papers

- Cummings, A.K., Pope, K.L., & Mak, G. (2023). Resetting the baseline: using machine learning to find lost meadows. *Landscape Ecology* 38, 2639–2653. [link](https://link.springer.com/article/10.1007/s10980-023-01726-7) · [pdf](/docs/pdfs/cummings2023.pdf)
- Pope, K.L. & Cummings, A.K. (2023). Recovering the lost potential of meadows to help mitigate challenges facing California's forests and water supply. *California Fish and Wildlife Journal* 109(1). [pdf](/docs/pdfs/pope2023.pdf)
