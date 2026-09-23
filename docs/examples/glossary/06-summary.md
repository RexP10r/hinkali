# Summary

**Definition:** The agent's memory field: a sliding-window summarization of older conversation turns, stored with the conversation and updated by a separate background LLM call. `HISTORY_MAX_MESSAGES` sets the recent window, `SUMMARY_INTERVAL` the summarization batch.

**Abbreviations:** none

**Example:** With `HISTORY_MAX_MESSAGES=4` and `SUMMARY_INTERVAL=2`, every second new message past the window folds the older turns into `summary` — outside the response path.

**See:** [cascade RAG](01-cascade-rag.md) — the summary is injected into its prompts; [quantized model](04-quantized-model.md).

**Source:** crates/lm-orchestrator/src/db/summary.rs; crates/lm-orchestrator/src/server/routes.rs; docs/ARCHITECTURE.md § Memory.
