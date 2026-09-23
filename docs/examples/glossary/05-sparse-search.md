# Sparse search

**Definition:** Lexical search over TF-IDF vectors: tokenization with English stemming and vocabulary pruning; the vocabulary caps at `MAX_SPARSE_SIZE` terms. Sparse vectors are recomputed in the background after ingest, so a sparse query issued right after `docs/add` may miss the freshest documents.

**Abbreviations:** TF-IDF — term frequency times inverse document frequency

**Example:** `POST /api/docs/search/sparse` with `{"query": "heading path"}` returns the same `results` shape as dense search.

**See:** [dense search](03-dense-search.md); [vector store](08-vector-store.md); [chunk](02-chunk.md).

**Source:** crates/lm-orchestrator/src/embeddings/sparse.rs; docs/ARCHITECTURE.md § Vector Search.
