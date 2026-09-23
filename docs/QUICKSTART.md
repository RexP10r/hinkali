# Quickstart

One small glossary, one question. This walkthrough assumes the stack from the
[README](../README.md#requirements) is ready: Docker, `protoc`, `uv`, `jq`,
and the model files configured in `.env`.

## 1. Start

From the repository root:

```bash
cp .env.example .env        # first run only; point MODEL_PATH at your GGUF file
./hinkali.sh --launch
```

The launcher generates the Python protobuf modules, starts Redis, MongoDB and
Qdrant, then `lm-service` and `lm-orchestrator`. Logs land in `./logs/`.

## 2. Health check

```bash
curl -fsS http://localhost:8080/health
# {"status":"ok"}
```

## 3. Add the sample glossary

`docs/examples/` carries a small glossary for this walkthrough: the A–Z
navigator, the learning-order navigator, and eight term files
(`docs/examples/glossary/NN-slug.md`). Ingest all of it:

```bash
for f in docs/examples/glossary.md docs/examples/glossary_priority.md docs/examples/glossary/*.md; do
  jq -n --rawfile text "$f" --arg name "$(basename "$f")" \
    '{documents: [{text: $text, name: $name, file_format: "md"}]}' \
    | curl -fsS -X POST http://localhost:8080/api/docs/add \
        -H 'Content-Type: application/json' --data @-
done
# {"added":1} — once per file (ten files)
```

Dense vectors are written before each response; sparse vectors are recomputed
in the background.

## 4. Ask

```bash
curl -fsS -X POST http://localhost:8080/api/chat \
  -H 'Content-Type: application/json' \
  --data '{"conversation_id": "quickstart", "message": {"role": "user", "content": "Per the glossary, what is a chunk and which context does it carry?"}}'
# {"conversation_id":"quickstart","message":{"role":"assistant","content":"..."}}
```

The exact wording depends on the configured model; the answer must repeat the
glossary definition: a bounded slice of a document that carries its section's
heading path — the fact lives in `docs/examples/glossary/02-chunk.md`.

## 5. Check the source

```bash
curl -fsS -X POST http://localhost:8080/api/docs/search/dense \
  -H 'Content-Type: application/json' \
  --data '{"query": "bounded slice of a document"}' | jq '.results[0]'
```

The top result is a chunk of `02-chunk.md` with its heading path — the context
the answer was grounded in.

## 6. Same flow in the TUI

```bash
set -a; source .env; set +a   # the TUI reads SERVER_URL and friends from the environment
cargo run -p tui
```

- `/docs recursive docs/examples` — load the sample glossary; confirm with `y`.
- Type the question and press Enter.
- `Ctrl-C` quits.

## 7. Stop

```bash
./hinkali.sh --stop
```
