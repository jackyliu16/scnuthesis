1. `/fonts: No such file or directory`
   在 flake.nix 中引入了当前路径下的 fonts 文件夹，这个文件夹中保存了一些相对比较常见的字体
   可能是因为两种原因导致无法编译的情况，
   1. 由于 fonts 作为 git submodule 尚未被下载，可以通过 `git submodule init` AND `git submodule update` 注册并下载对应的仓库
       （此处我使用的是我的私有仓库，所以说需要修改成为包含你们字体的，或者比如 [justrajdeep::fonts](https://github.com/justrajdeep/fonts) 的公开仓库）
      1. 如果你不在意（我只是比较怕）分享字体可能带来的影响，你可以直接将这个 git submodule 从这个注册路径删除，然后手动创建一个同名的文件夹，将对应的字体放进去
      2. 如何判断字体是否是 latex 要的？ 通过 `nix develop` 进入到 `nix devShells` 然后通过 `fc-list | grep ${FONT_NAME}` 
         搜索出一个类似于`/nix/store/...-fonts/Times_New_Roman.ttf: Times New Roman:style=Regular,Normal,obyčejné,Standard,Κανονικά,Normaali,Normál,Normale,Standaard,Normalny,Обычный,Normálne,Navadno,thường,Arrunta`
         这种的东西（后面的东西不一定一致，不过只需要关心`:`后面的第一段 Times New Roman 代表了这个字体的名字）


   2. 问题可能由 nix 版本导致，请将 nix 版本设置为 2.18.1 (保证能跑), 2.19 会报错。2.20 [以上似乎是可以直接跑](https://github.com/NixOS/nix/pull/7862#issuecomment-1908577578)。

2. 编译出错检查：
```
error: builder for '/nix/store/nm2xlld9wjypwkkw28xzqpv9b148jkba-mydocument.pdf.drv' failed with exit code 1;
       last 10 log lines:
       >  ...
       > ! Emergency stop.
       >  ...
...
```

直接看最后 20 行 `nix log /nix/store/nm2xlld9wjypwkkw28xzqpv9b148jkba-mydocument.pdf.drv | tail -n 20`, 发现错误原因在 `The font "Times New Roman" cannot be found.` 表示没有找到你用的字体

```
(/nix/store/75qczv2yiy8ybxzd5sby8366mdw9ws5v-texlive-combined-2023-texmfdist/te
x/latex/ctex/config/ctex.cfg)

! Package fontspec Error: The font "Times New Roman" cannot be found.

For immediate help type H <return>.
 ...

l.38

?
! Emergency stop.
 ...

l.38

No pages of output.
Transcript written on main.log.
```

3. 模板文件出现了 `\usepackage, \RequirePackage` 跨行的情况 如
```nix

\RequirePackage[a4paper
  , left=3cm
  , right=2.3cm
  , top=2.3cm
  , bottom=2.6cm
  , headheight=10cm
  , headsep=0.3cm]{geometry}
\setlength{\headsep}{0.6cm}
```

```
error:
       … while calling the 'derivationStrict' builtin

         at /builtin/derivation.nix:9:12: (source not available)

       … while evaluating derivation 'mydocument.pdf'
         whose name attribute is located at /nix/store/n2g5cqwv8qf5p6vjxny6pg3blbdij12k-source/pkgs/stdenv/generic/make-derivation.nix:331:7

       … while evaluating attribute 'nativeBuildInputs' of derivation 'mydocument.pdf'

         at /nix/store/n2g5cqwv8qf5p6vjxny6pg3blbdij12k-source/pkgs/stdenv/generic/make-derivation.nix:375:7:

          374|       depsBuildBuild              = elemAt (elemAt dependencies 0) 0;
          375|       nativeBuildInputs           = elemAt (elemAt dependencies 0) 1;
             |       ^
          376|       depsBuildTarget             = elemAt (elemAt dependencies 0) 2;

       error: value is null while a list was expected
make: *** [Makefile:9：build] 错误 1
```

