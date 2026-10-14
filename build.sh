#!/bin/sh
# Builds the installable web app (PWA) into docs/ (served by GitHub Pages) from src/app.html.
set -e
cd "$(dirname "$0")"
mkdir -p "${OUT:-docs}"
{
  printf '<!doctype html><html lang="ko"><head><meta charset="utf-8">'
  printf '<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">'
  printf '<meta name="theme-color" content="#F2B705"><link rel="manifest" href="manifest.webmanifest">'
  printf '<link rel="icon" href="icon.svg" type="image/svg+xml"><link rel="apple-touch-icon" href="icon-192.png">'
  printf '<meta name="apple-mobile-web-app-capable" content="yes">'
  printf '<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0;font:14px system-ui,sans-serif}img{max-width:100%%}[hidden]{display:none!important}</style>'
  printf '<script>window.__PWA__=true</script></head><body>'
  cat src/app.html
  printf '</body></html>\n'
} > "${OUT:-docs}/index.html"
cp src/manifest.webmanifest src/sw.js src/icon.svg "${OUT:-docs}/"
[ -f src/icon-192.png ] && cp src/icon-*.png "${OUT:-docs}/" || true
# bump the cache name so phones pick up the new version
sed -i "s/__BUILD__/$(date +%Y%m%d%H%M%S)/" "${OUT:-docs}/sw.js"
echo "built ${OUT:-docs}/"
