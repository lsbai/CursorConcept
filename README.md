# CursorConcept

Windows 11 Cursor Concept（HD v2.2，作者 Jepri Creations）打包到本仓库，同时提供 **Windows** 和 **Linux** 两种安装方案。两个子目录里的内容直接拷贝就能用，不需要再做格式转换。

原始光标图稿来自上游：
[`PSGitHubUser1/Windows-11-Cursor-Concept-Pro-v2.0`](https://github.com/PSGitHubUser1/Windows-11-Cursor-Concept-Pro-v2.0)
（或在 DeviantArt / [Kofi](https://ko-fi.com/jepricreations) 上支持原作者）。

## 目录结构

```
CursorConcept/
├── README.md          ← 本文件
├── win/               ← Windows 端的 cursor 方案
│   ├── README.md      ← Windows 安装说明
│   ├── install.cmd    ← 一键安装脚本（管理员权限）
│   ├── Scheme.png     ← 10 种 spinner 配色总览
│   ├── Preview.jpg    ← 光标外观预览
│   ├── dark/          ← 深色底用（dark/regular, dark/small）
│   └── light/         ← 浅色底用
└── linux/             ← Xcursor 主题（Linux / Wayland）
    ├── README.md      ← Linux 安装说明、主题列表
    ├── install.sh     ← 一键安装脚本
    ├── Scheme.png     ← 配色总览
    ├── dark/          ← 10 个深色主题
    └── light/         ← 10 个浅色主题
```

## 配色含义

![Scheme](linux/Scheme.png)

10 种 `busy` / `working` spinner 的颜色方案（其余 15 个静态光标在所有配色里一致）：

| 目录         | 颜色                          |
| ------------ | ---------------------------- |
| `01_default` | Win11 默认蓝色环             |
| `02_classic` | 经典 Win7 蓝色环             |
| `03_amber`   | 琥珀色                       |
| `04_green`   | 绿色                         |
| `05_indigo`  | 靛蓝                         |
| `06_red`     | 红色                         |
| `07_squid`   | 鱿鱼色（青）                 |
| `08_purple`  | 紫色                         |
| `09_candy`   | 糖果色（粉/红）             |
| `10_sunset`  | 日落色（橙）                 |

每个颜色又分 **深色版**（`dark/`，对应暗色桌面）和 **浅色版**（`light/`，对应浅色桌面）。在 Linux 端展开为 20 个独立主题，详见 [linux/README.md](linux/README.md)。

`regular` 与 `small` 差别仅在静态光标和 `working` spinner 的细节风格（regular 是抗锯齿高清版，small 是像素风版）。

## 快速安装

* **Windows** → 看 [win/README.md](win/README.md)，推荐 `install.cmd`。
* **Linux / Wayland** → 看 [linux/README.md](linux/README.md)，推荐 `install.sh`。

## 致谢

光标美术 © Jepri Creations。Linux 端的 Xcursor 主题由 [`win2xcur`](https://github.com/quantum5/win2xcur) 转换而来。