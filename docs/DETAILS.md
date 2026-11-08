# Edge 便携版：设置与构建细节

本文收录压缩包目录形态、渠道识别与仓库关系说明。安装、更新、功能配置见仓库根目录的 [README](../README.md)，使用说明与常见问题见 [下载页面](https://piracola.github.io/ChromiumPortable/edge/)。

## 为什么解压出来是 Microsoft\Edge\Application 这样的目录

Edge 按主程序的路径识别自己的渠道身份：只有路径形如官方安装位置 `...\Microsoft\Edge\Application\...` 时，浏览器才自认为 Stable 渠道，设置页里的「设为默认浏览器」才可用；路径不匹配时会被当成内部渠道，按钮显示「无法将 Canary 渠道设为默认浏览器」并置灰。这是 Edge 自身的判断逻辑，任何便携化方案（包括不注入任何 DLL 的绿色版）都会遇到。

本项目的压缩包不做别名、副本或路径补丁，而是**直接按官方形态摆放**：版本目录就装在 `Microsoft\Edge\Application\` 下面，`msedge.exe` 与 `chrome++.ini` 都在版本目录里。这样 Edge 看到的就是官方那条路径，渠道识别为 Stable，默认浏览器设置恢复正常；而且整个方案里没有任何依赖绝对路径的东西，文件夹搬动、改名都不需要额外处理。

想验证是否生效：打开 `edge://version`，版本号后面的括号内没有「internal」字样即为正常。

## 渠道维护

目前项目默认同步构建 Stable 版本，如后续扩展其他渠道，将在同一流程内统一维护。

## 本地构建

本地构建由 [ChromiumPortable](https://github.com/Piracola/ChromiumPortable) 的图形构建器完成，操作步骤见其 [开发文档](https://github.com/Piracola/ChromiumPortable/blob/main/docs/DEVELOPMENT.md)。

## 相关仓库

- [ChromiumPortable](https://github.com/Piracola/ChromiumPortable)：通用构建核心
- [Chrome-Portable](https://github.com/Piracola/Chrome-Portable)：同系列 Google Chrome 便携版
- [Helium_Portable](https://github.com/Piracola/Helium_Portable)：同系列 Helium 便携版
