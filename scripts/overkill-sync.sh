#!/usr/bin/env bash
# Copy template-managed OverkillOS files into an existing project checkout.
# Does NOT replace init.sh; use when .overkill/ already exists.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET=""
DRY_RUN=0
BACKUP=0

usage() {
  echo "Usage: $0 --target <path> [--source <path>] [--dry-run] [--backup]"
  echo "  --source  Template root (default: parent of scripts/, i.e. this repo)"
  echo "  --target  Existing project directory (required)"
  echo "  --dry-run Print actions only"
  echo "  --backup  Copy replaced files to <target>/.overkill/.sync-backup/<timestamp>/"
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source) SOURCE="$(cd "$2" && pwd)"; shift 2 ;;
    --target) TARGET="$(cd "$2" && pwd)"; shift 2 ;;
    --dry-run) DRY_RUN=1; shift ;;
    --backup) BACKUP=1; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown arg: $1" >&2; usage ;;
  esac
done

[[ -n "$TARGET" ]] || { echo "ERROR: --target required" >&2; usage; }

MANIFEST="$SOURCE/scripts/MANAGED-FILES.txt"
[[ -f "$MANIFEST" ]] || { echo "ERROR: Missing $MANIFEST" >&2; exit 1; }

TS="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$TARGET/.overkill/.sync-backup/$TS"

should_skip() {
  local base="$1"
  local ign="$TARGET/.overkill/.sync-ignore"
  [[ -f "$ign" ]] || return 1
  grep -qFx "$base" "$ign" 2>/dev/null
}

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" || "$line" =~ ^# ]] && continue
  rel="${line//$'\r'/}"
  rel="${rel#"${rel%%[![:space:]]*}"}"
  [[ -z "$rel" ]] && continue
  src="$SOURCE/$rel"
  dst="$TARGET/$rel"
  base="$(basename "$rel")"
  if should_skip "$base"; then
    echo "SKIP (sync-ignore): $rel"
    continue
  fi
  if [[ ! -f "$src" ]]; then
    echo "WARN: source missing, skip: $rel" >&2
    continue
  fi
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "COPY $rel"
    continue
  fi
  mkdir -p "$(dirname "$dst")"
  if [[ "$BACKUP" -eq 1 && -f "$dst" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    cp "$dst" "$BACKUP_DIR/$rel"
  fi
  cp "$src" "$dst"
  echo "OK $rel"
done < "$MANIFEST"

if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "(dry-run complete)"
else
  echo "Sync complete: $SOURCE -> $TARGET"
fi
