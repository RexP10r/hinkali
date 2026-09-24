#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

uv run --with grpcio-tools python -m grpc_tools.protoc \
  --proto_path=../../proto \
  --python_out=. \
  --grpc_python_out=. \
  ../../proto/lm_service.proto
