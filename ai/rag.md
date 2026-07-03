Problem with naive rag, or motivation for GraphRag
* senstiive to the question, e.g., semantic equivalent stuff, verbal expression to cause unstable recall rate
* Chunking cuts down the contentxt, e.g., only recalls deployment but no config, even though config directly affects deployment
* Hard to eval
* Hard to associate different docs, as they are from different chunks
* same concept in similar docs, and hard for RAG to associate

Problem with GraphRAG
* Expensive to index, as indexing building and relationship building, community summary all needs LLM
* Hard to implement incremental
* Query latency
* Highly depenedent on the the quarliyt hte entity/relationship building, answer qualith may even be worse than traditional RAG

Common mitigation is to ask LLM to rewrite the original query to a few equivalents, and then query, but it does not solve the underlying conneciton within the user's asks

user question -> small model to identity user intent and generate the chain of thounghts -> generate inquiry points (small model) -> recall knowledge base -> consolidate CoT and knowledge point answers into LLM response


Eval
* good/bad is too coarse grained, because the result may be too much - clear question, vague question, invalid question. 
* question quality - is the inquriey itself clear enough
* answer qualith - accurancy and completeness
* root cause of the quality problem
* expected behaviors can be added to the regression test set

Add the historical case to the vector DB as the good examples so that it could be added to LLM on demand
Use multi models to cross eval, as the same model eval is more likely to be overly confident






