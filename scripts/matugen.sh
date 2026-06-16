#! /usr/bin/env bash

matugen image $(cat ~/Pictures/wallpaper/current) \
  --lightness-dark +0.0 \
  --lightness-light -0.0 \
  -t $1 \
  --source-color-index 0 \
  -m $2
