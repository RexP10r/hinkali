## Overview
The Python `lm-service` runs the llama-cpp-python library to serve LLM inference.
It connects to the Rust `lm-orchestrator` via gRPC. The Rust core is the central component responsible for managing:
- agent pipelines (currently RAG only)
- databases (Redis, MongoDB, Qdrant)
- tools

In the future, it will be decomposed into microservices.

## Cascade RAG
RAG is not a task that requires an iterative agentic loop. There is an algorithm for how humans process information, and the agent should follow the same approach.
Furthermore, this project focuses on local pipelines. Local quantized models have a known tendency to fall into infinite loops. The cascade pipeline addresses both of these issues.

## Memory
Message history is stored as BSON documents in MongoDB. Messages have a complex structure (tool calls, subagents in the future), so relational SQL-like databases are not suitable here.
Redis is used as a cache layer. Its necessity for a fully local pipeline is still under consideration.
MongoDB documents include a field for the agent's memory called `summary`. The summary is updated using a sliding window algorithm:
- let `n` be: the number of recent messages to keep in context
- let `m` be: the batch size of new messages to summarize

Initially, the summary is empty. It is updated when the following condition is met: `total_messages > n && (total_messages - n) % m == 0`.
These parameters can be configured via environment variables:
```env
HISTORY_MAX_MESSAGES=4
SUMMARY_INTERVAL=2
```

## Documents
Each document is parsed into a tree data structure based on heading hierarchy. When chunks are extracted, the full heading path is prepended to each chunk as markdown headers. This ensures that every chunk retains its document context, so semantically related chunks remain discoverable even when separated by unrelated sections. For example:
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

## Vector Search
The current cascade pipeline uses a JSON response field to invoke tools. At present, the model calls exactly one tool per query -- either sparse search or dense search (a hybrid approach is planned for the future).
TF-IDF vectors serve as the sparse representation. MiniLM embeddings provide the dense vectors and must be downloaded separately.
