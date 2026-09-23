# Quantized model

**Definition:** A GGUF model file (for example Qwen3.5-9B Q4_K_M) served by llama-cpp-python behind the gRPC `lm-service`. `LLAMA_N_GPU_LAYERS` controls how many layers go to the GPU (`0` = CPU); `MODEL_PATH` points at the file and `MODEL_NAME` is the status label.

**Abbreviations:** GGUF — the file format used by llama.cpp model files

**Example:** `.env`: `MODEL_PATH=../../models/Qwen3.5-9B-Q4_K_M.gguf` with `LLAMA_N_GPU_LAYERS=0` (CPU sample) or `LLAMA_N_GPU_LAYERS=-1` (CUDA override, all layers).

**See:** [cascade RAG](01-cascade-rag.md) — every cascade call runs on this model; [summary](06-summary.md).

**Source:** crates/lm-service/core/providers/llama_cpp.py; crates/lm-service/config.py; .env.example.
