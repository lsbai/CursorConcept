#!/usr/bin/env bash
# CursorConcept - Linux 安装脚本
#
# 把 dark/ 和 light/ 下每个主题目录拷贝到 ~/.local/share/icons/。
# 每个主题都已自带 index.theme（含 Inherits=），可被 gsettings /
# KDE 系统设置直接识别。
#
# 用法：
#   ./install.sh                       安装全部（dark + light，共 20 个）
#   ./install.sh dark                  只安装深色 10 个
#   ./install.sh light                 只安装浅色 10 个
#   ./install.sh dark  system          装到 /usr/share/icons/（需 sudo）
#   ./install.sh light user            装到 ~/.local/share/icons/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TONE="${1:-all}"
DEST_KIND="${2:-user}"

case "$DEST_KIND" in
  user)   ICON_DIR="$HOME/.local/share/icons" ;;
  system) ICON_DIR="/usr/share/icons"        ;;
  *) echo "未知安装目标: $DEST_KIND（应为 user 或 system）" >&2; exit 1 ;;
esac

# 系统级安装：非 root 时自动 sudo 重启。
if [ "$DEST_KIND" = "system" ] && [ "$(id -u)" -ne 0 ]; then
  echo "系统级安装需要 root，改用 sudo 重启本脚本"
  exec sudo "$0" "$@"
fi

mkdir -p "$ICON_DIR"

count=0
for tone_dir in "$SCRIPT_DIR/dark" "$SCRIPT_DIR/light"; do
  tone=$(basename "$tone_dir")
  case "$TONE" in
    all)   ;;
    "$tone") ;;
    *) continue ;;
  esac

  for theme in "$tone_dir"/*; do
    [ -d "$theme" ] || continue
    name=$(basename "$theme")
    rm -rf "$ICON_DIR/$name"
    cp -r "$theme" "$ICON_DIR/$name"
    count=$((count + 1))
    echo "[ok] $name  ->  $ICON_DIR/$name"
  done
done

cat <<EOF
============================================
已安装 $count 个主题到 $ICON_DIR。

应用方式（GNOME / Cinnamon / XFCE / Wayland）：
  gsettings set org.gnome.desktop.interface cursor-theme 'CursorConcept'
（想要 Red/Purple/Sunset 等其它配色，把引号内主题名换掉即可。）

KDE Plasma（Wayland）：
  系统设置 → 外观 → 光标 → 选择 CursorConcept。

Snap 应用（Firefox / Chromium）：
  本脚本默认装到 ~/.local/share/icons/，Snap 看不到。
  请改用：./install.sh $TONE system
============================================
EOF