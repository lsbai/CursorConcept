# Linux 端光标主题

![Scheme](Scheme.png)

20 个开箱即用的 Xcursor 主题，从 Windows 11 Cursor Concept **v2.2** 的源文件转换而来。保留了原 .cur / .ani 里 32 / 48 / 64 / 96 px 四档原生尺寸，热点坐标与原图严格对齐（没有缩放 / 重采样，不会出锯齿也不会"歪"）。

## 目录结构

```
linux/
├── README.md
├── install.sh     ← 一键安装脚本
├── Scheme.png     ← 10 种配色总览
├── dark/          ← 深色底用主题
│   ├── CursorConcept/            ← 默认蓝色 spinner（dark tone）
│   ├── CursorConcept-Classic/    ← 经典蓝色 spinner
│   ├── CursorConcept-Amber/
│   ├── CursorConcept-Green/
│   ├── CursorConcept-Indigo/
│   ├── CursorConcept-Red/
│   ├── CursorConcept-Squid/
│   ├── CursorConcept-Purple/
│   ├── CursorConcept-Candy/
│   └── CursorConcept-Sunset/
└── light/         ← 浅色底用主题
    ├── CursorConcept-Light/
    ├── CursorConcept-Classic-Light/
    ├── CursorConcept-Amber-Light/
    ├── CursorConcept-Green-Light/
    ├── CursorConcept-Indigo-Light/
    ├── CursorConcept-Red-Light/
    ├── CursorConcept-Squid-Light/
    ├── CursorConcept-Purple-Light/
    ├── CursorConcept-Candy-Light/
    └── CursorConcept-Sunset-Light/
```

* `dark/CursorConcept` 与 `light/CursorConcept-Light` 是主款：自带 15 个静态光标 + 默认蓝色 spinner，约 158 个 cursor 文件（含 X11 hash 别名）。
* `dark/CursorConcept-<配色>` 与 `light/CursorConcept-<配色>-Light` 是配色变体：只放 `wait` / `working` 等 9 个 loading 相关的 cursor 文件，其余通过 `index.theme` 的 `Inherits=` 字段从主款继承（每个 ~5 MB）。

## 安装

### 一键脚本

```bash
./install.sh                  # 全部 20 个主题，装到 ~/.local/share/icons/
./install.sh dark             # 只装 dark/ 下 10 个
./install.sh light            # 只装 light/ 下 10 个
./install.sh dark   system    # 装到 /usr/share/icons/（系统级，需要管理员）
./install.sh light  user      # 装到当前用户（默认就是 user）
```

`system` 安装时若非 root，脚本会自动 `sudo` 提权重启自己。

### 手动安装（单主题）

```bash
mkdir -p ~/.local/share/icons
cp -r dark/CursorConcept-Red ~/.local/share/icons/
```

### 手动安装（全部）

```bash
cp -r dark/* light/* ~/.local/share/icons/
```

## 应用

### GNOME / Cinnamon / XFCE（Wayland 或 X11）

```bash
gsettings set org.gnome.desktop.interface cursor-theme 'CursorConcept'
# 想换配色：
gsettings set org.gnome.desktop.interface cursor-theme 'CursorConcept-Red'
```

无需登出，新聚焦的窗口立刻生效。

### KDE Plasma（Wayland / KWin）

**系统设置 → 外观 → 光标** → 在下拉里选 `CursorConcept` 或任意 `CursorConcept-<配色>`。

### 临时测试（不安装）

```bash
XCURSOR_THEME=CursorConcept-Sunset XCURSOR_SIZE=32 xterm
```

## 注意事项

* **Snap 应用**（Firefox、Chromium 等）只读 `/usr/share/icons/` 下的主题，不会看 `~/.local/share/icons/`。要给 snap 用，必须用 `./install.sh <dark|light> system` 装到系统级。
* 主题里包含 X11 hash 别名（如 `5c6cd98b3f3ebcb1f9c7f1c204630408`）的符号链接，老的 X11 应用和合成器按 hash 找光标也能命中。

## 重新生成

仓库根 [README.md](../README.md) 里说明了转换流程基于 [`win2xcur`](https://github.com/quantum5/win2xcur)；原始 Windows 源在 [`../win/`](../win/)。要重新生成 Linux 端，参见上游 `win2xcur` 的文档。