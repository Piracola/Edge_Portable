<div align="center">

# Edge Portable

Portable Microsoft Edge with Chrome++ integrated, built automatically by GitHub Actions, in Windows x64 and ARM64 archives.

[![Latest release][badge-release]][link-release]
[![Total downloads][badge-downloads]][link-release]
[![Build status][badge-build]][link-actions]
[![License][badge-license]][link-license]

**Language / 语言:** [简体中文](README.md) · **English**

**[⬇ Download the latest release][link-release]** · **[📖 Usage guide & FAQ][link-site]**

</div>

## About

The project checks Microsoft's official Edge offline installers on a daily schedule, integrates Chrome++, and repackages the result as a portable build in both x64 and ARM64. Only the Stable channel is built for now; any channel added later will be maintained through the same pipeline.

A set of custom enhancements comes preconfigured — see `chrome++.ini` for the details.

The build system is provided by [ChromiumPortable](https://github.com/Piracola/ChromiumPortable); this repository only holds the build configuration. For a local build, see the core repository's [development docs](https://github.com/Piracola/ChromiumPortable/blob/main/docs/DEVELOPMENT.md).

## Quick start

1. Download an archive from [Releases](https://github.com/Piracola/Edge_Portable/releases/latest) — `Edge_Portable_Win64_...7z` for x64, `Edge_Portable_arm64_...7z` for Windows on Arm — and extract it anywhere.
2. Run `开始.bat` to create the `Edge.lnk` shortcut inside the extraction folder, then launch from that shortcut.

## Why does the archive extract into a Microsoft\Edge\Application folder?

Edge derives its channel identity from the main executable's path. Only when the path looks like the official install location, `...\Microsoft\Edge\Application\...`, does the browser consider itself the Stable channel and offer "Set as default browser". On a mismatched path it treats itself as an internal channel and greys the button out with a message saying the Canary channel cannot be set as default. That judgement lives in Edge itself, so every portability approach runs into it — including a no-install build that injects no DLL at all.

So this archive uses no aliases, copies, or path patches: it lays things out exactly like an official install. The version folder sits under `Microsoft\Edge\Application\`, with `msedge.exe` and `chrome++.ini` inside it. Edge then sees the official path, identifies as Stable, and default-browser settings work again. Nothing in the layout depends on an absolute path either, so moving or renaming the whole folder needs no extra work.

To confirm it took effect, open `edge://version`: no "internal" tag in the parentheses after the version number means you're good.

## Updating

1. Close the browser.
2. Delete the `Microsoft` folder, or rename it to `Microsoft old` if you want a rollback option.
3. Extract the `Microsoft` folder and `开始.bat` from the new archive; leave `Data` and `Cache` alone.
4. Run `开始.bat` once so the shortcut points at the new version.

## Features

Everything below is included and enabled by default unless noted; adjust or switch it off in `chrome++.ini`:

- Profile data and cache live in the `Data` and `Cache` folders at the extraction root
- Double-click a tab to close it; the last tab stays open
- Scroll the mouse wheel over the tab strip to switch tabs
- Open whatever sits in the address bar, or a bookmark, in a new foreground tab
- View saved passwords without going through the Windows sign-in prompt
- Optional extras: close tabs with the right mouse button, boss key, translate shortcut, key remapping, start/exit hooks and more (off by default; see `chrome++.ini`)
- The release carries no Microsoft Edge Update, so the browser never replaces itself with a full install; extension and security component updates keep working
- More enhancements are documented in `chrome++.ini`

## Changing the data directory

The location is set by the `data_dir` and `cache_dir` lines in `Microsoft\Edge\Application\<version>\chrome++.ini`. Defaults are `%app%\..\..\..\..\Data` and `%app%\..\..\..\..\Cache`, where `%app%` is the folder holding `msedge.exe` — four levels up lands exactly on the extraction root.

Absolute paths are accepted and directories are created as needed. Note that the file is **UTF-16 encoded** (pick "Unicode" when saving from Notepad).

Because the defaults are relative to the program folder, moving the whole tree needs no edits. Switch to an absolute path if you want data stored outside the program folder.

## Uninstalling

Delete the extraction root. The portable build writes nothing to the registry. If you had set it as your default browser, point Windows back at your previous browser first.

## Related projects

- [ChromiumPortable](https://github.com/Piracola/ChromiumPortable): shared build core
- [Chrome-Portable](https://github.com/Piracola/Chrome-Portable): the Google Chrome portable build
- [Helium_Portable](https://github.com/Piracola/Helium_Portable): the Helium portable build

## Credits

| Project | Role |
| --- | --- |
| [Bush2021/chrome\_plus](https://github.com/Bush2021/chrome_plus) | Core portability components (Chrome++ / version.dll / setdll) |
| [Bush2021/edge_installer](https://github.com/Bush2021/edge_installer) | Fallback version lookup for Edge |
| Microsoft Edge CDP API | Official version lookup and installer download |

## License

Source in this repository is MIT licensed.

- Microsoft Edge is copyright Microsoft

---

<div align="center">

<sub>Built and maintained by</sub>

**Piracola**

</div>

<!-- Badge labels: percent-encode spaces, otherwise shields.io cannot parse the URL. -->
[badge-release]: https://img.shields.io/github/v/release/Piracola/Edge_Portable?display_name=tag&style=flat-square&color=1d7c84&label=latest%20release
[badge-downloads]: https://img.shields.io/github/downloads/Piracola/Edge_Portable/total?style=flat-square&color=2ea043&label=total%20downloads
[badge-build]: https://img.shields.io/github/actions/workflow/status/Piracola/Edge_Portable/build.yml?branch=main&style=flat-square&label=build%20status
[badge-license]: https://img.shields.io/github/license/Piracola/Edge_Portable?style=flat-square&color=6e7681&label=license

[link-release]: https://github.com/Piracola/Edge_Portable/releases/latest
[link-site]: https://piracola.github.io/ChromiumPortable/en/edge/
[link-actions]: https://github.com/Piracola/Edge_Portable/actions/workflows/build.yml
[link-license]: https://github.com/Piracola/Edge_Portable/blob/main/LICENSE
