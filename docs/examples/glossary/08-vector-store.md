# Vector store

**Definition:** The Qdrant-backed storage behind both search routes: one point per chunk with its dense vector, plus the TF-IDF vocabulary persisted in the collection metadata. The orchestrator initializes the store before serving requests, so an unreachable Qdrant stops startup.

**Abbreviations:** none

**Example:** `QDRANT_URL=http://localhost:6334` (gRPC) and `QDRANT_COLLECTION_NAME=knowledge_base`; docker-compose binds the storage to `~/.config/hinkali/qdrant_storage`.

**See:** [chunk](02-chunk.md); [sparse search](05-sparse-search.md); [dense search](03-dense-search.md).

**Source:** crates/lm-orchestrator/src/vector/qdrant.rs; crates/lm-orchestrator/src/main.rs; docker-compose.yml.
