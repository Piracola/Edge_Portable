<div align="center">

# Edge 便携版

全自动构建的 Microsoft Edge 便携版，集成 Chrome++ 增强组件，提供纯净、高效的浏览体验。

[![最新版本][badge-release]][link-release]
[![总下载量][badge-downloads]][link-release]
[![构建状态][badge-build]][link-actions]
[![许可证][badge-license]][link-license]

**[⬇ 下载最新版本][link-release]** · **[📖 使用说明与常见问题][link-site]**

</div>

> 想了解构建系统或新增浏览器？见 [ChromiumPortable](https://github.com/Piracola/ChromiumPortable)——本仓库仅是其构建配置之一。

## 仓库导航

- [Edge 便携版下载页](https://piracola.github.io/ChromiumPortable/edge/)：安装、更新、校验与常见问题的完整说明。
- [ChromiumPortable（主仓库/构建核心）](https://github.com/Piracola/ChromiumPortable)：通用构建核心仓库。
- [Chrome-Portable](https://github.com/Piracola/Chrome-Portable)：同系列 Google Chrome 便携版项目。
- [Helium_Portable](https://github.com/Piracola/Helium_Portable)：同系列 Helium 便携版项目。

## 项目简介

本项目全自动构建，每天定时检查 Microsoft 官方是否有最新 Edge 离线安装包更新，集成 Chrome++ 组件并封装为便携版。项目预配置了自定义增强功能，具体配置请查看 `chrome++.ini`。

目前项目默认同步构建 Stable 版本，如后续扩展其他渠道，将在同一流程内统一维护。

## 快速开始

1. 从 [Releases](https://github.com/Piracola/Edge_Portable/releases/latest) 下载压缩包，解压到任意位置
2. 运行 `开始.bat` 生成 `Edge.lnk` 快捷方式，之后从快捷方式启动

## 更新

1. 关闭浏览器
2. 删除 `Microsoft` 文件夹或重命名为 `Microsoft old` 以便于回退版本。
3. 解压新版压缩包内的 `Microsoft` 文件夹和 `开始.bat`（`Data`、`Cache` 保持不动）。
4. 运行一次 `开始.bat`（快捷方式里带着版本号，需要重新指向新版本）。

## 功能特性

以下功能均已默认启用，可在 `chrome++.ini` 中调整或关闭：

- 用户数据及缓存均存储于解压根目录的 `Data` 和 `Cache` 文件夹
- 双击关闭标签页、保留最后一个标签页
- 悬停标签栏时滚轮切换标签页
- 新建前台标签页打开地址栏内容或书签
- 免验证系统登录密码即可查看已保存密码
- 支持右键关闭标签、老板键、翻译快捷键、按键映射、启动/退出钩子等扩展（默认未启用，详见 `chrome++.ini`）
- 发布包不携带 Microsoft Edge Update，因此不会自行替换整套浏览器；扩展和安全组件更新保持可用
- 更多增强功能请查看 `chrome++.ini`

<details>
<summary><b>为什么解压出来是 Microsoft\Edge\Application 这样的目录</b></summary>

Edge 按主程序的路径识别自己的渠道身份：只有路径形如官方安装位置 `...\Microsoft\Edge\Application\...` 时，浏览器才自认为 Stable 渠道，设置页里的「设为默认浏览器」才可用；路径不匹配时会被当成内部渠道，按钮显示「无法将 Canary 渠道设为默认浏览器」并置灰。这是 Edge 自身的判断逻辑，任何便携化方案（包括不注入任何 DLL 的绿色版）都会遇到。

所以本项目的压缩包不做别名、副本或路径补丁，而是**直接按官方形态摆放**：版本目录就装在 `Microsoft\Edge\Application\` 下面，`msedge.exe` 与 `chrome++.ini` 都在版本目录里。这样 Edge 看到的就是官方那条路径，渠道识别为 Stable，默认浏览器设置恢复正常；而且整个方案里没有任何依赖绝对路径的东西，文件夹搬动、改名都不需要额外处理。

想验证是否生效：打开 `edge://version`，版本号后面的括号内没有「internal」字样即为正常。

</details>

<details>
<summary><b>更改数据目录位置</b></summary>

数据目录的位置由 `Microsoft\Edge\Application\<版本号>\chrome++.ini` 里的 `data_dir` 和 `cache_dir` 两行决定，默认值是 `%app%\..\..\..\..\Data` 和 `%app%\..\..\..\..\Cache`（`%app%` 代表 `msedge.exe` 所在目录，上跳四级正好落到解压根目录）。值支持绝对路径，目录会自动创建。注意这个文件是 **UTF-16 编码**（记事本另存时选「Unicode」）。

默认路径本就跟着程序走，整个文件夹搬动不需要改，只有想把数据放到程序外（比如另一个分区）时才需要动它。

</details>

## 卸载

删除解压根目录即可，便携版不写注册表。若之前设置过默认浏览器，先在 Windows 设置中改回原浏览器。

## 本地构建

本地构建由主仓库的图形构建器完成，见 [ChromiumPortable](https://github.com/Piracola/ChromiumPortable)。

## 致谢

本项目基于以下优秀开源项目构建：

| 项目 | 说明 |
| --- | --- |
| [Bush2021/chrome\_plus](https://github.com/Bush2021/chrome_plus) | 提供核心便携化组件（Chrome++ / version.dll / setdll） |
| [Bush2021/edge_installer](https://github.com/Bush2021/edge_installer) | Edge 版本兜底查询 |
| Microsoft Edge CDP API | Edge 官方版本查询与安装包下载 |

## 许可证

本项目源码遵循 MIT 许可证。

- Microsoft Edge 浏览器版权归 Microsoft 所有

---

<div align="center">

<sub>Built and maintained by</sub>

**Piracola**

</div>

<!-- 徽标定义：中文标签需 percent-encode，否则 shields.io 无法解析。 -->
<!-- 修改标签文字时请一并更新编码，例如 最新版本 -> %E6%9C%80%E6%96%B0%E7%89%88%E6%9C%AC -->
[badge-release]: https://img.shields.io/github/v/release/Piracola/Edge_Portable?display_name=tag&style=flat-square&color=1d7c84&label=%E6%9C%80%E6%96%B0%E7%89%88%E6%9C%AC
[badge-downloads]: https://img.shields.io/github/downloads/Piracola/Edge_Portable/total?style=flat-square&color=2ea043&label=%E6%80%BB%E4%B8%8B%E8%BD%BD%E9%87%8F
[badge-build]: https://img.shields.io/github/actions/workflow/status/Piracola/Edge_Portable/build.yml?branch=main&style=flat-square&label=%E6%9E%84%E5%BB%BA%E7%8A%B6%E6%80%81
[badge-license]: https://img.shields.io/github/license/Piracola/Edge_Portable?style=flat-square&color=6e7681&label=%E8%AE%B8%E5%8F%AF%E8%AF%81

[link-release]: https://github.com/Piracola/Edge_Portable/releases/latest
[link-site]: https://piracola.github.io/ChromiumPortable/edge/
[link-actions]: https://github.com/Piracola/Edge_Portable/actions/workflows/build.yml
[link-license]: https://github.com/Piracola/Edge_Portable/blob/main/LICENSE
