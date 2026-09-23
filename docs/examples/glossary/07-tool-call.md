# Tool call

**Definition:** The single search the pre-retrieval step may request for one query: sparse (`search_tfidf`) or dense (`search_lm`). The request is a JSON field of the model's response — an `action` carrying `tool_name` and a `tool_input` with the query — and at most one tool runs per query.

**Abbreviations:** none

**Example:** The model returns an action with `tool_name: search_lm` and the query; the orchestrator executes it and hands the retrieved chunks to post-retrieval.

**See:** [sparse search](05-sparse-search.md); [dense search](03-dense-search.md); [cascade RAG](01-cascade-rag.md).

**Source:** crates/lm-orchestrator/src/tools/search_sparse.rs; crates/lm-orchestrator/src/tools/search_dense.rs; crates/lm-orchestrator/src/agent/rag/schema.rs.
