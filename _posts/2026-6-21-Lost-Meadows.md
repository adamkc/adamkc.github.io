---
published: true
layout: post
title: Finding lost meadows
---

Meadows in the Sierra Nevada tend to occur along low-gradient benches, generally between 1,500 and 3,000 m, where surface water slows, groundwater exchange occurs, and a high water table can persist late into the dry season. These conditions support wetland vegetation, predominantly sedges, grasses, and forbs, along with woody plants such as willow that tolerate low-oxygen soils. They also make meadows valuable out of proportion to their size: intact meadows store groundwater and sustain summer baseflows, capture sediment, store carbon, create natural fire breaks, and provide habitat for a diversity of plants and wildlife. These functions are increasingly important in a range experiencing more frequent drought and more severe wildfire.

Unfortunately, most meadows in the Sierra Nevada have been degraded and no longer provide the values they did before Euro-American settlement. Beginning in the mid-1800s, livestock grazing and the manipulation of drainage for roads and grazable area concentrated diffuse, multi-threaded flow paths into single incised channels. Once a channel incises, it drains surface and ground water to the elevation of the new channel bed; the water table drops, and with the added pressure of fire suppression, forest and scrub vegetation replace the meadow plants. A meadow can therefore disappear from view while the low-gradient valley floor that produced it, and usually an incised channel, remain.

We built the Lost Meadows model on that persistence. We reasoned that the vegetation changes when a meadow is degraded but the underlying hydrogeomorphology does not, so the physical setting of a meadow should remain detectable long after its plants are gone. Using more than 11,000 hand-digitized riparian meadows across 60 watersheds and 25,300 km² of the Sierra Nevada, we trained a random forest model to recognize the geomorphic and climatic signature of meadow ground while excluding any vegetation-based predictors. The predictors are derived from a 10 m elevation model and a snow dataset: local relief, slope, distance to the nearest channel, topographic wetness, and median April snowpack. Topographic wetness at the 100 m scale and snowpack were the most informative. We then applied the model across the landscape to estimate where meadows were likely to have occurred.

The model predicts nearly three times more potential meadow area than is currently mapped. We intend that number to reset the baseline: existing meadow maps describe the range after more than a century of loss, not the extent it once supported or could support again. The models performed well by standard measures, with most watersheds scoring above 0.89 AUC, and when we compared predictions against an independent meadow inventory the model had never seen, predicted area coincided with real meadows roughly ten times more often than expected by chance. In a sample examined with LiDAR and aerial imagery, most predicted areas were covered by upland forest yet retained the incised channels characteristic of a drained meadow.

We do not claim that every predicted area was historically a meadow. The predicted area is a mixture: meadows that were never digitized, former meadows that have dried and converted to forest, and ground that shares the geomorphology of a meadow but may never have supported one. The model recognizes the physical setting; it cannot distinguish among these on its own. We used a deliberately conservative probability threshold, so the totals are likely underestimates, and some predicted meadows will not return to meadow even with restoration.

## The map

We have made the predictions available as a downloadable map, organized by watershed:

<iframe src="https://adamcummings.net/lost-meadows-map/" title="Lost Meadows Predictions map" style="border: 1px solid #ddd; width: 100%; height: 600px;" loading="lazy"></iframe>

[Open the full map](https://adamcummings.net/lost-meadows-map/)

Select a HUC10 watershed to download its prediction files: high-confidence polygons, medium-confidence polygons, and the underlying raster. The model assigns each 10 m pixel a probability between 0 and 1; the high-confidence layer uses a strict threshold and the medium-confidence layer a more permissive one, so the medium layer identifies more candidate ground at the cost of more false positives. Files are hosted on Google Drive and split by watershed, so a single basin can be retrieved without downloading the entire range.

Two limitations are worth stating plainly. The model was trained in the Sierra Nevada and on a single hydrogeomorphic type, the stream-associated, or riparian, meadow; it is therefore most reliable within that range and that meadow type and should be read more cautiously elsewhere. It also performs best where meadow ground is geomorphically distinct from its surroundings. Where the terrain is already low and flat, or where meadows occupy unusual settings, the model is more likely to under-predict.

A prediction is best treated as a hypothesis. It identifies ground with the physical characteristics of a meadow and a location worth investigating; whether a meadow remains to be restored is a question best answered in the field.

## Papers

- Cummings, A.K., Pope, K.L., & Mak, G. (2023). Resetting the baseline: using machine learning to find lost meadows. *Landscape Ecology* 38, 2639–2653. [link](https://link.springer.com/article/10.1007/s10980-023-01726-7) · [pdf](/docs/pdfs/cummings2023.pdf). The model and its development and validation.
- Pope, K.L. & Cummings, A.K. (2023). Recovering the lost potential of meadows to help mitigate challenges facing California's forests and water supply. *California Fish and Wildlife Journal* 109(1). [pdf](/docs/pdfs/pope2023.pdf). How the predictions can be incorporated into wildfire and post-wildfire restoration planning.
