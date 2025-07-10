#!/bin/sh

CACHE_FILE="$HOME/.cache/orca_mesa_json_path"

if [ -f "$CACHE_FILE" ]; then
  MESA_JSON_PATH=$(cat "$CACHE_FILE")
else
  MESA_JSON_PATH=$(find /nix/store -type f -name 50_mesa.json 2>/dev/null | head -n 1)
  echo "$MESA_JSON_PATH" > "$CACHE_FILE"
fi

export __GLX_VENDOR_LIBRARY_NAME=mesa
export __EGL_VENDOR_LIBRARY_FILENAMES="$MESA_JSON_PATH"
export MESA_LOADER_DRIVER_OVERRIDE=zink
export GALLIUM_DRIVER=zink
export WEBKIT_DISABLE_DMABUF_RENDERER=1

exec orca-slicer "$@"
