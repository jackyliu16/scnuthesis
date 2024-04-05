# scnuthesis

A simple latex template base on (cucthesis) and (overlays::SCNU-my-article convert) with nix flake support 
一个简单的，基于下面两个样式实现的 Nix 封装，目标在于实现可复现的文档编译功能。

支持环境如下：

| Platform                     | Multi User         | `root` only | Maturity          |
|------------------------------|:------------------:|:-----------:|:-----------------:|
| Linux (x86_64 & aarch64)     | ✓ (via [systemd])  | ✓           | Stable            |
| MacOS (x86_64 & aarch64)     | ✓                  |             | Stable (See note) |
| Valve Steam Deck (SteamOS)   | ✓                  |             | Stable            |
| WSL2 (x86_64 & aarch64)      | ✓ (via [systemd])  | ✓           | Stable            |
| Podman Linux Containers      | ✓ (via [systemd])  | ✓           | Stable            |
| Docker Containers            |                    | ✓           | Stable            |
| Linux (i686)                 | ✓ (via [systemd])  | ✓           | Unstable          |

```
# 最简单的编译方式
make install-nix
make 
```

- https://www.overleaf.com/latex/templates/scnu-my-article/jkbbvhnddtsw
- https://github.com/latexstudio/cucthesis

- NOTE: 建议你通过将 fonts 部分的文件保存在单独的私有仓库中以避免对于字体文件进行分发可能带来的法律诉讼风险。

- NOTE：如果需要添加 `\usepackage` OR `\RequirePackage` 请务必保证其在一行内。

- NOTE: 如果你没有安装 nix，建议你先安装一下，`make install-nix` 会自动执行 The Determinate Nix Installer 在大部分的电脑系统中安装 Nix
同理，你也可以通过 `make uninstall-nix` 卸载安装

