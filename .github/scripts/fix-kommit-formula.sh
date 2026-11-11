#!/usr/bin/env bash
# Patch Formula/kommit.rb after cargo-dist regenerates it on each release.
#
# cargo-dist's Homebrew template always emits a `version` line and never a
# `test do` block, both of which `brew test-bot --only-tap-syntax` rejects.
# This script is idempotent: running it on an already patched file is a no-op.
set -euo pipefail

formula="${1:-Formula/kommit.rb}"

# The version is already scanned from the release URLs.
sed -i.bak '/^  version "[^"]*"$/d' "$formula"
rm -f "$formula.bak"

if ! grep -q '^  test do$' "$formula"; then
  if [[ "$(tail -n 1 "$formula")" != "end" ]]; then
    echo "error: $formula does not end with the class's closing 'end'" >&2
    exit 1
  fi

  tmp="$(mktemp)"
  sed '$d' "$formula" > "$tmp"
  cat >> "$tmp" <<'RUBY'

  test do
    assert_match version.to_s, shell_output("#{bin}/kommit --version")
  end
end
RUBY
  cat "$tmp" > "$formula"
  rm -f "$tmp"
fi
