# Cascade RAG

**Definition:** The two-step retrieval-augmented agent: pre-retrieval analyzes the request and either answers directly or requests one search tool; post-retrieval evaluates the retrieved context and writes the final answer. At most two LLM calls per response, and each step must return JSON validated against a schema.

**Abbreviations:** RAG — retrieval-augmented generation

**Example:** A question whose answer is already in the conversation: pre-retrieval answers directly (one call). A question that needs the knowledge base: pre-retrieval returns a tool call, post-retrieval answers from the retrieved chunks (two calls).

**See:** [tool call](07-tool-call.md) — the one search the first step may request; [sparse search](05-sparse-search.md); [dense search](03-dense-search.md); [summary](06-summary.md) — the separate background call.

**Source:** docs/ARCHITECTURE.md § Cascade RAG; crates/lm-orchestrator/src/agent/rag/cascade.rs.
