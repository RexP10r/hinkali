# Glossary — priority navigator (learning order)

Second view over the same term files as the A–Z navigator
[`glossary.md`](glossary.md). Lines sorted by first encounter on the learning
path for this project, NOT by difficulty: each stage is written so that it
only relies on terms from earlier stages. Read top to bottom. Term files
`docs/examples/glossary/NN-slug.md` stay the source of truth; glosses below
mirror the A–Z navigator.

Maintenance rules:

- Every term file has exactly one line in THIS file and exactly one in the
  A–Z navigator; no dangling links, no orphans.
- A new term file gets its stage line at creation — stage = where a newcomer
  first needs it, not where it is hardest.
- A gloss edit propagates to both navigators in the same change.

Stages: 1 the response path → 2 retrieval → 3 memory.

## Stage 1 — The response path

What happens to one question, and where the generation happens.

- [cascade RAG](glossary/01-cascade-rag.md) — the two-step RAG agent: pre-retrieval may answer directly or request one search tool; post-retrieval writes the final answer; at most two LLM calls per response.
- [tool call](glossary/07-tool-call.md) — the single search the pre-retrieval step may request per query (`search_tfidf` or `search_lm`), expressed as a JSON field of the response.
- [quantized model](glossary/04-quantized-model.md) — a GGUF model file served by llama-cpp-python behind the gRPC `lm-service`; `LLAMA_N_GPU_LAYERS` controls GPU offload.

## Stage 2 — Retrieval

How documents become searchable text.

- [chunk](glossary/02-chunk.md) — a bounded slice of a document produced by the Markdown splitter, carrying its section's heading path as prepended Markdown headers.
- [vector store](glossary/08-vector-store.md) — the Qdrant-backed store of chunks and the TF-IDF vocabulary; it serves both search routes and is required at startup.
- [sparse search](glossary/05-sparse-search.md) — lexical search over TF-IDF vectors with English stemming and vocabulary pruning; vectors are recomputed in the background after ingest.
- [dense search](glossary/03-dense-search.md) — semantic search over MiniLM embeddings (ONNX Runtime), served through the vector store.

## Stage 3 — Memory

What is kept between questions.

- [summary](glossary/06-summary.md) — the agent's memory field: a sliding-window summary of older conversation turns, updated by a separate background LLM call.
