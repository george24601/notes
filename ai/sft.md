
Focus on why do this, what is discovered, how to solve this, and what is the effect
Focus on the decision point and the hard questions to show my thinking and independence

#### cleaning up the data
When building the domain data, many answers have high duplicates, to avoid model training to prefer repeated sample, I deduped with BERT + clustering, and reducing data size from 200k to 80k, while preserving the variety of intentions

#### Model is not performing well
* first version, we found that model is not performing well in multiple rounds, and RCA shows that that is because data does not have enough context, so I build 4 ways of multiple rounds of history assembly, and picked one way after comparing. These measures increased BLUE by 12%
* Second version, we found that response to low frequency intent in not stable, so we customized class weight to guide model generalization. As a result, recall rated increased by 6%

* Goal
* Data process (how to acquire and clean data)
* Modeling (which one, why choose this one, any optimization)
* Effect analysis and optimization iteration (how to tune and why you tune like this)
* Assess design and result (which metrics and what is the improvement)

LoRA tuning -> optimization closure
Script -> show engineering capability
Failure or setbacks -> structure improvement and optimization 

