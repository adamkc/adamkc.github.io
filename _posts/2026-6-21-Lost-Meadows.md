---
published: true
layout: post
title: Finding lost meadows
---

A meadow is mostly a story about water and dirt. Where a mountain valley flattens out, water slows down, fine sediment settles, and the water table sits high enough to favor grasses and sedges over conifers. In the Sierra Nevada that usually happens on low-gradient benches between about 1,500 and 3,000 m, recharged each year by snowmelt. That geometry is the meadow. The plants are just what grows on top of it.

That distinction matters, because the plants can leave while the geometry stays. Starting around the 1850s, livestock grazing, roads, and ditching cut and confined the channels that kept meadow water tables high, and once a channel incises it drains the groundwater down to the new streambed. Add a century of fire suppression and conifers and brush move onto the dried-out surface. From the air those places stop reading as meadows. But the low-gradient valley floor that made them meadows is still sitting there, usually with an incised channel cut through it.

So a few years ago we went looking for the ones that got erased. The idea, from [our 2023 paper in *Landscape Ecology*](https://link.springer.com/article/10.1007/s10980-023-01726-7) ([pdf](/docs/pdfs/cummings2023.pdf)), was to learn the part of a meadow that doesn't disappear: its shape. We took the roughly 11,000 mapped, stream-associated meadows in the Sierra Nevada MultiSource Meadow Polygons compilation, spread across 60 HUC10 watersheds and 25,300 km², and trained a random forest to recognize the hydrogeomorphic signature of meadow ground while ignoring vegetation entirely. The predictors are things you can pull from a bare-earth elevation model and a snow dataset: topographic wetness, local relief, vertical distance to the nearest channel, and April snowpack. The two that carried the most weight were wetness at the 100 m scale and snowpack. Then we ran the model over the rest of the landscape and asked where else the terrain looks like this.

It flagged about three times more meadow-shaped ground than is currently mapped. The point of that number is to reset the baseline: the meadow maps we have describe the range after 150 years of loss, not what it can actually support. And the model is accurate at the job it was given. Most watersheds scored above 0.89 AUC, and when we tested predictions against an independent meadow inventory the model had never seen, it landed on real meadow ground about ten times more often than chance. We also pulled LiDAR and aerial imagery for a sample of hits: most of the "new" ground is now under upland forest, and about 90% of it has an incised channel running through it, which is exactly what a drained meadow looks like.

A prediction still isn't a meadow, though, and it's worth being clear about what the map shows. The flagged area is a mix: meadows that were simply never digitized, real meadows that dried out and grew over, and ground that has meadow-like geomorphology but may never have been a meadow. The model only sees the shape, so it can't separate those three. We set a deliberately conservative cutoff, so if anything the map under-counts. And some of these places won't return to meadow even if you restore them.

## The map

The predictions aren't much use sitting in a folder, so they're on a map you can click:

<iframe src="https://adamcummings.net/lost-meadows-map/" title="Lost Meadows Predictions map" style="border: 1px solid #ddd; width: 100%; height: 600px;" loading="lazy"></iframe>

[Open the full map](https://adamcummings.net/lost-meadows-map/)

Pick a HUC10 watershed and download its prediction files: high-confidence polygons, medium-confidence polygons, and the raster they came from. The model scores every 10 m pixel from 0 to 1; high confidence uses a strict cutoff and medium a looser one, so medium hands you more candidate ground in exchange for more false positives. Everything lives on Google Drive, split by watershed, so you can grab one basin without pulling down the whole Sierra.

Two things to keep in mind. The model learned what a meadow is from the Sierra Nevada and from one type of meadow, the stream-associated kind, so it's most trustworthy there and gets shakier the farther you drift from that. And it does best where meadow ground stands out from its surroundings; where the terrain is already flat or the meadows sit in unusual settings, it has a harder time and tends to under-predict.

Mostly, though, a prediction is a hypothesis. It's a spot on the map saying the ground here has the right bones. Whether there's anything left to restore is a question you answer by going there.

## Papers

- Cummings, A.K., Pope, K.L., & Mak, G. (2023). Resetting the baseline: using machine learning to find lost meadows. *Landscape Ecology* 38, 2639–2653. [link](https://link.springer.com/article/10.1007/s10980-023-01726-7) · [pdf](/docs/pdfs/cummings2023.pdf). The model, and how it was built and validated.
- Pope, K.L. & Cummings, A.K. (2023). Recovering the lost potential of meadows to help mitigate challenges facing California's forests and water supply. *California Fish and Wildlife Journal* 109(1). [pdf](/docs/pdfs/pope2023.pdf). How the predictions feed into wildfire and post-fire sediment planning.
