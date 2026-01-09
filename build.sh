#!/bin/bash

set -euo pipefail

IMAGE_NAME="mzebrak/dotfiles-base"

echo "Building ${IMAGE_NAME}..."
docker build -t "${IMAGE_NAME}" -f Dockerfile.full .

echo "Done. Run with: docker run -it --rm -e TERM -e COLORTERM ${IMAGE_NAME}"
