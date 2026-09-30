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

## 功能特性

以下功能均已默认启用，可在 `chrome++.ini` 中调整或关闭：

- 用户数据及缓存均存储于程序同级目录的 `Data` 和 `Cache` 文件夹
- 双击关闭标签页、保留最后一个标签页
- 悬停标签栏时滚轮切换标签页
- 新建前台标签页打开地址栏内容或书签
- 免验证系统登录密码即可查看已保存密码
- 支持右键关闭标签、老板键、翻译快捷键、按键映射、启动/退出钩子等扩展（默认未启用，详见 `chrome++.ini`）
- 发布包不携带 Microsoft Edge Update，因此不会自行替换整套浏览器；扩展和安全组件更新保持可用
- 更多增强功能请查看 `chrome++.ini`

## 快速开始

**安装**

1. 下载：访问 [Releases](https://github.com/betacola/Edge_Portable/releases/latest) 获取最新版本（`Edge_Portable_Win64_...7z`）
2. 解压：将压缩包解压至任意位置
3. 运行 `开始.bat` 文件创建快捷方式

**更新**

1. 关闭浏览器。
2. 备份旧版 Edge 文件夹中的 `Data` 目录（复制到安全位置）。
3. 删除旧版 Edge 文件夹。
4. 解压新版 Edge 文件夹到同级目录。
5. 把备份的 `Data` 放回新版 Edge 文件夹。

**卸载**

删除 Edge 文件夹即可完成卸载（便携，不写注册表）。

**本地构建**（Windows + Python 3，需将 `ChromiumPortable` 检出到同级目录）

```powershell
python -m pip install requests
$env:PYTHONPATH="..\ChromiumPortable"
python -m portable_builder --config browser.json --target edge_stable --workdir . build
```

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
- Chrome++ 组件版权归原作者所有

本项目采用 GitHub Actions 自动检查更新，版本号与 Edge 官方 Stable 分支保持一致。查看 [Releases](https://github.com/betacola/Edge_Portable/releases) 获取历史版本。

---

<div align="center">

<sub>Built and maintained by</sub>

**betacola**

</div>

<!-- 徽标定义：中文标签需 percent-encode，否则 shields.io 无法解析。 -->
<!-- 修改标签文字时请一并更新编码，例如 最新版本 -> %E6%9C%80%E6%96%B0%E7%89%88%E6%9C%AC -->
[badge-release]: https://img.shields.io/github/v/release/betacola/Edge_Portable?display_name=tag&style=flat-square&color=1d7c84&label=%E6%9C%80%E6%96%B0%E7%89%88%E6%9C%AC
[badge-downloads]: https://img.shields.io/github/downloads/betacola/Edge_Portable/total?style=flat-square&color=2ea043&label=%E6%80%BB%E4%B8%8B%E8%BD%BD%E9%87%8F
[badge-build]: https://img.shields.io/github/actions/workflow/status/betacola/Edge_Portable/build.yml?branch=main&style=flat-square&label=%E6%9E%84%E5%BB%BA%E7%8A%B6%E6%80%81
[badge-license]: https://img.shields.io/github/license/betacola/Edge_Portable?style=flat-square&color=6e7681&label=%E8%AE%B8%E5%8F%AF%E8%AF%81

[link-release]: https://github.com/betacola/Edge_Portable/releases/latest
[link-site]: https://piracola.github.io/ChromiumPortable/edge/
[link-actions]: https://github.com/betacola/Edge_Portable/actions/workflows/build.yml
[link-license]: https://github.com/betacola/Edge_Portable/blob/main/LICENSE
