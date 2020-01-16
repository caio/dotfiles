#!/usr/bin/env bash

set -e

wget 'https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/ra_lsp_server-linux' -O /tmp/ra_lsp_server
chmod +x /tmp/ra_lsp_server
mv /tmp/ra_lsp_server ${HOME}/bin/
