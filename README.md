# scnuthesis

A simple latex template base on [cucthesis](https://github.com/latexstudio/cucthesis
) and [overleaf::SCNU-my-article](https://www.overleaf.com/latex/templates/scnu-my-article/jkbbvhnddtsw) with nix flake support 
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

# 最简单的操作方式

```
make install-nix 安装 nix 包管理器
make 编译包

# 使用 vscode 与 latex-workshop 联合使用
make dev
code .
安装 latex-workshop 插件
在 latex-workshop 中选择 Build LaTex Project :: Recipe: latexmk (xelatex)
同时选择 View LaTex PDF :: View in VSCode tab
编辑 main.tex 文件，右侧的 tab 会自动更新

。。。
make uninstall-nix 删除nix 包管理器以及其衍生物
```

## NOTE

- NOTE: 建议你通过将 fonts 部分的文件保存在单独的私有仓库中以避免对于字体文件进行分发可能带来的法律诉讼风险。
- NOTE：如果需要添加 `\usepackage` OR `\RequirePackage` 请务必保证其在一行内。
- NOTE: 如果你没有安装 nix，建议你先安装一下，`make install-nix` 会自动执行 The Determinate Nix Installer 在大部分的电脑系统中安装 Nix
同理，你也可以通过 `make uninstall-nix` 卸载安装
- NOTE: 目前采用的以 ".?submodules=1" URL 修饰符实现 git submodule 加载的形式似乎只在 nix --verion == 2.18.1 能保证通过，在 2.19 测试的时候无法正确将对应 submodule 文件复制到对应位置。不过这一问题[有望](https://github.com/NixOS/nix/pull/7862#issuecomment-1908577578)在 nix version 2.20 之后版本得到完整解决。


## Ref
- https://www.overleaf.com/latex/templates/scnu-my-article/jkbbvhnddtsw
- https://github.com/latexstudio/cucthesis
