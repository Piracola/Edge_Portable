<div align="center">

# Edge 便携版

集成 Chrome++ 的 Microsoft Edge 便携版，由 GitHub Actions 自动构建，提供 Windows x64 与 ARM64 压缩包。

[![最新版本][badge-release]][link-release]
[![总下载量][badge-downloads]][link-release]
[![构建状态][badge-build]][link-actions]
[![许可证][badge-license]][link-license]

**语言 / Language:** **简体中文** · [English](README.en.md)

**[⬇ 下载最新版本][link-release]** · **[📖 使用说明与常见问题][link-site]**

</div>

## 项目简介

本项目每天定时检查 Microsoft 官方 Edge 离线安装包更新，集成 Chrome++ 并封装为便携版，同时提供 x64 与 ARM64 两种架构。目前只构建 Stable 渠道，以后扩展其他渠道时会继续放在同一套流程里维护。

项目预配置了自定义增强功能，具体配置请查看 `chrome++.ini`。

构建系统由 [ChromiumPortable](https://github.com/Piracola/ChromiumPortable) 提供，本仓库只保存构建配置；本地构建步骤见核心仓的[开发文档](https://github.com/Piracola/ChromiumPortable/blob/main/docs/DEVELOPMENT.md)。

## 快速开始

1. 从 [Releases](https://github.com/Piracola/Edge_Portable/releases/latest) 下载压缩包（`Edge_Portable_Win64_...7z` 为 x64，`Edge_Portable_arm64_...7z` 为 Windows on Arm），解压到任意位置。
2. 运行 `开始.bat` 生成 `Edge.lnk` 快捷方式，之后从快捷方式启动。

## 为什么解压出来是 Microsoft\Edge\Application 这样的目录

Edge 按主程序的路径判断自己的渠道身份：只有路径形如官方安装位置 `...\Microsoft\Edge\Application\...` 时，浏览器才认为自己是 Stable 渠道，设置页里的「设为默认浏览器」才可用。路径不匹配时它会被当成内部渠道，按钮显示「无法将 Canary 渠道设为默认浏览器」并置灰。这是 Edge 自身的判断逻辑，任何便携化方案（包括不注入任何 DLL 的绿色版）都会碰到。

所以压缩包不做别名、副本或路径补丁，而是直接按官方形态摆放：版本目录就装在 `Microsoft\Edge\Application\` 下面，`msedge.exe` 和 `chrome++.ini` 都在版本目录里。这样 Edge 看到的就是官方那条路径，渠道识别为 Stable，默认浏览器设置恢复正常；整个方案里也没有依赖绝对路径的东西，文件夹搬家、改名都不用额外处理。

想验证是否生效：打开 `edge://version`，版本号后面的括号里没有「internal」字样即为正常。

## 更新

1. 关闭浏览器。
2. 删除 `Microsoft` 文件夹或重命名为 `Microsoft old` 以便回退版本。
3. 解压新版压缩包内的 `Microsoft` 文件夹和 `开始.bat`，`Data`、`Cache` 保持不动。
4. 运行一次 `开始.bat`，使快捷方式指向新版本。

## 功能特性

以下增强均已集成，除注明外默认启用，可在 `chrome++.ini` 中调整或关闭：

- 用户数据及缓存均存储于解压根目录的 `Data` 和 `Cache` 文件夹
- 双击关闭标签页、保留最后一个标签页
- 悬停标签栏时滚轮切换标签页
- 新建前台标签页打开地址栏内容或书签
- 免验证系统登录密码即可查看已保存密码
- 支持右键关闭标签、老板键、翻译快捷键、按键映射、启动/退出钩子等扩展（默认未启用，详见 `chrome++.ini`）
- 发布包不携带 Microsoft Edge Update，因此不会自行替换整套浏览器；扩展和安全组件更新保持可用
- 更多增强功能请查看 `chrome++.ini`

## 更改数据目录位置

数据目录的位置由 `Microsoft\Edge\Application\<版本号>\chrome++.ini` 里的 `data_dir` 和 `cache_dir` 两行决定，默认值是 `%app%\..\..\..\..\Data` 和 `%app%\..\..\..\..\Cache`（`%app%` 代表 `msedge.exe` 所在目录，上跳四级正好落到解压根目录）。

值支持绝对路径，目录会自动创建。注意这个文件是 **UTF-16 编码**（记事本另存时选「Unicode」）。

默认路径相对于主程序目录，移动整个文件夹不需要修改。需要将数据存放到程序目录之外时，可改用绝对路径。

## 卸载

删除解压根目录即可，便携版不写注册表。若之前设置过默认浏览器，先在 Windows 设置中改回原浏览器。

## 相关项目

- [ChromiumPortable](https://github.com/Piracola/ChromiumPortable)：通用构建核心
- [Chrome-Portable](https://github.com/Piracola/Chrome-Portable)：同系列 Google Chrome 便携版
- [Helium_Portable](https://github.com/Piracola/Helium_Portable)：同系列 Helium 便携版

## 致谢

本项目使用以下开源项目与上游服务：

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
