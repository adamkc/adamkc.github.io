---
published: true
layout: post
title: Finding lost meadows
---

Meadows in the Sierra Nevada tend to occur along low-gradient geologic benches at elevations from 1,500 to 3,000 m where they can be recharged annually by snowmelt. There, water can slow, spread, and infiltrate into spongy, organic soils, and a high groundwater table can persist late into the dry season. These conditions support vegetation that is predominantly herbaceous plants, including sedges, other graminoids, and forbs, but also woody plants such as willows that can tolerate low-oxygen soils. The result is a habitat that is valuable out of proportion to its size. In the absence of degradation, wet meadows improve a catchment's water quality and predictability by attenuating and dispersing flood flows, filtering water through hyporheic exchange, and retaining sediment. They store carbon, create natural fire breaks, and support a diversity of wildlife; great grey owls, for instance, rely on wet meadows in the Sierra Nevada for vole prey.

Most of these meadows have been degraded and no longer provide the values they did before Euro-American settlement. Beginning in the mid-1800s, people drained meadows to increase the grazable area and allow for road and trail construction: sinuous, multi-threaded, sedge-lined flow paths were concentrated into single, often linear channels. Once a channel incises, it drains surface and ground water to the elevation of the new channel bed. With the lowered groundwater elevation, and with the added pressure of fire suppression, forest and scrub vegetation replaced typical meadow vegetation. A meadow can therefore disappear from view while the low-gradient valley floor that produced it, and usually an incised channel, remain.

We built the Lost Meadows model on that persistence. We hypothesized that vegetation would change but geomorphology would remain, so the physical setting of a meadow should stay detectable long after its plants are gone. Using more than 11,000 hand-digitized riparian meadows across 60 watersheds and 25,300 km² of the Sierra Nevada, we trained a random forest model to recognize the geomorphic and climatic signature of meadow ground. We did not include vegetation-based predictors because we were specifically looking for locations that may have transitioned to non-meadow vegetation but otherwise have similar characteristics as existing meadows. The predictors come from a 10 m elevation model and a snow dataset: local relief, slope, distance to the nearest channel, topographic wetness, and median April snowpack. The most important of them describe smooth and low-slope surfaces with unimpeded flow paths where water accumulates from precipitation and snowmelt.

Using readily available data and accessible statistical techniques, we detected about three times more potential meadow area than is currently recognized within a complex, mountainous landscape. The intent is to reset the baseline to historical conditions, countering the shifting baseline syndrome by which our existing maps describe the range after more than a century of loss rather than the extent it once supported. The models performed well by standard measures, with most watersheds scoring above 0.89 AUC; when compared against an independent meadow inventory the model had never seen, predicted area coincided with real meadows roughly ten times more often than expected by chance. In a sample examined with LiDAR and aerial imagery, most predicted areas were covered by upland forest yet retained the incised channels characteristic of a drained meadow.

We do not claim that all the model-predicted habitats were historically meadows; however, they do represent areas with similar geomorphic and climatic characteristics of extant riparian meadows. The predicted area is a mixture of existing but undocumented meadows, non-meadowlands that may have converted from meadows due to lost function and forest encroachment, and areas with meadow-like geomorphology that may never have been meadow. We used a deliberately conservative probability threshold, so the totals are likely underestimates, and some of the model-predicted lost meadows will probably not return to actual meadows even if restoration is implemented.

## The map

We have made the predictions available as a downloadable map, organized by watershed:

<iframe src="https://adamcummings.net/lost-meadows-map/" title="Lost Meadows Predictions map" style="border: 1px solid #ddd; width: 100%; height: 600px;" loading="lazy"></iframe>

[Open the full map](https://adamcummings.net/lost-meadows-map/)

Select a HUC10 watershed to download its prediction files: high-confidence polygons, medium-confidence polygons, and the underlying raster. The model assigns each 10 m pixel a probability between 0 and 1; the high-confidence layer uses a strict threshold and the medium-confidence layer a more permissive one, so the medium layer identifies more candidate ground at the cost of more false positives. Files are hosted on Google Drive and split by watershed, so a single basin can be retrieved without downloading the entire range.

We focused on riparian meadows because they are fed by both surface water and subsurface groundwater so are greatly affected by channel incision, and the model was trained only on that type and only within the Sierra Nevada; it is therefore most reliable there and should be read more cautiously elsewhere. The model also performs best where meadow ground is geomorphically distinct from its surroundings. Where the terrain is already low and flat, or where meadows occupy unusual settings, it is more likely to under-predict.

A prediction is best treated as a hypothesis. It identifies ground with the physical characteristics of a meadow and a location worth investigating; whether a meadow remains to be restored is a question best answered in the field.

## Papers

- Cummings, A.K., Pope, K.L., & Mak, G. (2023). Resetting the baseline: using machine learning to find lost meadows. *Landscape Ecology* 38, 2639–2653. [link](https://link.springer.com/article/10.1007/s10980-023-01726-7) · [pdf](/docs/pdfs/cummings2023.pdf). The model and its development and validation.
- Pope, K.L. & Cummings, A.K. (2023). Recovering the lost potential of meadows to help mitigate challenges facing California's forests and water supply. *California Fish and Wildlife Journal* 109(1). [pdf](/docs/pdfs/pope2023.pdf). How the predictions can be incorporated into wildfire and post-wildfire restoration planning.
