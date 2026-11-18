#!/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

# Clean build, so public/ mirrors exactly the current sources. Together with
# rsync --delete, this also removes deleted pages from the server.
emacs --batch -Q -l build.el

# Never sync an empty or broken build: --delete would wipe the server.
if [[ ! -f public/index.html ]]; then
    echo "public/index.html missing, aborting deploy" >&2
    exit 1
fi

rsync -avz --delete --chmod=D755,F644 public/ webmaster@latte:/var/www/site
