## General 
Python `lm-service` runs llama-cpp-python library just to get answer from llm.
It connected to Rust lm-orchestrator via gRPC. Rust core is the main structure, that manages:
- agent pipelines (currently RAG only)
- databases (redis, mongodb, qdrant)
- tools
Later it will decomposed into microservices.

## Cascade RAG
RAG is not a task that requires cycle. There is an exact algorithm how humen process information. Agent should do the same.
Furthermore, this project is focused on local pipelines, local quatizied models have a known pattern of falling to infinite loop. Cascade pipeline solves those problems at once.

## Memory
Messages history is stored as bson documents in mongodb. Messages have complex structure (tool calls, subagents later) so relational sql-like dabases are useless here.
Redis obviously is just a cache db. There is a question if it is neccessary to local pipeline.
Mongodb docs have a field to store agent's memory called summary. Summary updates due to sliding window algorithm:
- let n be history context agent gets followed by user query
- let m be window size
So, initially we have an empty summary, it updates due to the condition below: `chat_length % m == n`. 
Those parameters can be set as environment variables:
```env
HISTORY_MAX_MESSAGES=4
SUMMARY_INTERVAL=2
```

## Documents
Each document is parsed to the tree data structure where each leaf contains the full path to it. So vectorizer can get chunks, those can be related to the topic of a document not straightly. For example:
```md
# Hom functors.md

## Formal Definition

Let $\mathcal{C}$ be a *locally small category*. Then:
- Objects of $\mathcal{C}: Denoted , B, X, Y, \dots \in \mathrm{Ob}(\mathcal{C})$
- Morphisms in $\mathcal{C}: For , Y \in \mathrm{Ob}(\mathcal{C})$,
  $$
  \mathrm{Hom}\_{\mathcal{C}}(X, Y) = {, f \mid f : X \to Y \text{ is a morphism in } \mathcal{C} ,}
  $$
  is a *set* (by the locally small assumption).
```

and

```md
# Hom functors.md

## Functoriality Axioms

### Identity Preservation

For any object $X \in \mathcal{C}$:

$$
\mathrm{Hom}_{\mathcal{C}}(A, \mathrm{id}_X) = \mathrm{id}_{\mathrm{Hom}_{\mathcal{C}}(A, X)}
$$

and similarly for the contravariant version:

$$
\mathrm{Hom}_{\mathcal{C}}(\mathrm{id}_X, B) = \mathrm{id}_{\mathrm{Hom}_{\mathcal{C}}(X, B)}
$$
```

## Vector search
Current cascade pipeline has a json field to call a tool. Currently, model can call sparse search or dense search at once (hybrid approach planned later).
So tfidf vector serve as sparse ones. Minilm embeddings are dense vectors (so thats why you need to download it).

