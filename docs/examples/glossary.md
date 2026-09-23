# Glossary — navigator

A–Z. One line per term: `[term](glossary/NN-slug.md)` — short gloss. Term files
live in `docs/examples/glossary/NN-slug.md`; NN is a stable append-only id
(never renumbered), the alphabet lives here. Every term file has exactly one
line below AND one stage line in the learning-order view
[`glossary_priority.md`](glossary_priority.md); no dangling links. Sources:
docs/ARCHITECTURE.md and the crates — each file cites its own. This glossary
is also the sample the [quickstart](../QUICKSTART.md) ingests.

- [cascade RAG](glossary/01-cascade-rag.md) — the two-step RAG agent: pre-retrieval may answer directly or request one search tool; post-retrieval writes the final answer; at most two LLM calls per response.
- [chunk](glossary/02-chunk.md) — a bounded slice of a document produced by the Markdown splitter, carrying its section's heading path as prepended Markdown headers.
- [dense search](glossary/03-dense-search.md) — semantic search over MiniLM embeddings (ONNX Runtime), served through the vector store.
- [quantized model](glossary/04-quantized-model.md) — a GGUF model file served by llama-cpp-python behind the gRPC `lm-service`; `LLAMA_N_GPU_LAYERS` controls GPU offload.
- [sparse search](glossary/05-sparse-search.md) — lexical search over TF-IDF vectors with English stemming and vocabulary pruning; vectors are recomputed in the background after ingest.
- [summary](glossary/06-summary.md) — the agent's memory field: a sliding-window summary of older conversation turns, updated by a separate background LLM call.
- [tool call](glossary/07-tool-call.md) — the single search the pre-retrieval step may request per query (`search_tfidf` or `search_lm`), expressed as a JSON field of the response.
- [vector store](glossary/08-vector-store.md) — the Qdrant-backed store of chunks and the TF-IDF vocabulary; it serves both search routes and is required at startup.
