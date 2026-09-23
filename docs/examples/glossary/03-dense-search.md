# Dense search

**Definition:** Semantic search over MiniLM embeddings: each chunk is embedded with ONNX Runtime (mean pooling, L2 normalization) and looked up in the vector store by vector similarity. Dense vectors are written before the ingest response, so the route works immediately after adding documents.

**Abbreviations:** none

**Example:** `POST /api/docs/search/dense` with `{"query": "bounded slice of a document"}` returns `{"results": [{"id": "...", "text": "...", "score": ...}]}`.

**See:** [sparse search](05-sparse-search.md) — the lexical companion; [chunk](02-chunk.md); [vector store](08-vector-store.md).

**Source:** crates/lm-orchestrator/src/embeddings/dense.rs; crates/lm-orchestrator/src/server/router.rs.
