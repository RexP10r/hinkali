`nexus` implements modern NLP approaches using modular pipelines. 

It provides:
- A local vectorized knowledge base for the agent (currently supports `.md` files only).
- Cascade RAG architecture with Schema-Guided-Reasoning (prevents quantized LLMs from entering infinite loops and gives a full control over the pipeline).
- A blazingly fast, memory-safe Rust core.

### Requirements

#### Prerequisites
Ensure the following are installed on your system:
- **Rust** (see `./crates/lm-orchestrator/Cargo.toml` for exact versions)
- **Python** (see `./crates/lm-service/pyproject.toml` for exact dependencies)
- **Docker & Docker Compose**
- **Protocol Buffers Compiler** (`protoc`)

#### Environment Configuration
- Initialize your environment file:
  ```bash
  cp .env.example .env
  ```
- Download a GGUF model (e.g., [Qwen3.5-9B-GGUF](https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/tree/main)) from Hugging Face.
  Create a `./models` directory and place the downloaded model there.
  Update your `.env` file with the model path:
  ```env
  MODEL_PATH=./models/llm.gguf
  MODEL_NAME=llm
  ```
  Download an embedding model (e.g., [all-MiniLM-L6-v2](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2/tree/main)) and configure its paths in `.env`:
  ```env
  EMBEDDING_MODEL_PATH=./models/minilm/model.onnx
  EMBEDDING_TOKENIZER_PATH=./models/minilm/tokenizer.json
  ```
- **Hardware Acceleration**: CPU is used by default. For CUDA acceleration, follow the [LLAMA_CPP_CUDA.md](./docs/LLAMA_CPP_CUDA.md) guide.

### Launching the Project

1. Start the backend services:
   ```bash
   ./nexus.sh --launch
   ```
   *(Inspect `nexus.sh` to understand local error handling. Runtime logs are saved in the `./logs` directory.)*
2. Launch the TUI client in a separate terminal:
   ```bash
   cargo run -p tui
   ```
