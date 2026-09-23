# Chunk

**Definition:** A bounded slice of a document produced by the Markdown splitter. The section's heading path is prepended as Markdown headers, and a section over `MAX_TOKENS = 254` is split at sentence or list-item boundaries; slices flush once they reach `MIN_TOKENS = 128`.

**Abbreviations:** none

**Example:** This file's chunks carry the path `# 02-chunk.md` + `# Chunk`, so retrieved text keeps its document and section context.

**See:** [vector store](08-vector-store.md) — where chunks are stored; [dense search](03-dense-search.md); [sparse search](05-sparse-search.md).

**Source:** crates/lm-orchestrator/src/vector/split_pipelines/md.rs; docs/ARCHITECTURE.md § Documents.
