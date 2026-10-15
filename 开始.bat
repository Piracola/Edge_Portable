@echo off
chcp 65001 >nul

set "APP_ROOT=%~dp0Microsoft\Edge\Application"
set "EDGE_EXE="

for /d %%d in ("%APP_ROOT%\*") do (
    if exist "%%d\msedge.exe" (
        set "EDGE_EXE=%%d\msedge.exe"
        goto :found
    )
)

echo 未找到 Microsoft\Edge\Application 下的版本目录
echo 请确认压缩包已完整解压，且旧版本文件夹已删除
pause
exit /b 1

:found
rem The shortcut target carries the version number, so re-create it after every
rem update: extract the new version first, then run this script again.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$s=New-Object -ComObject WScript.Shell; $l=$s.CreateShortcut('%~dp0Edge.lnk'); $l.TargetPath='%EDGE_EXE%'; $l.Arguments=''; $l.WorkingDirectory='%~dp0'; $l.IconLocation='%EDGE_EXE%,0'; $l.Save()"

if exist "%~dp0Edge.lnk" (
    echo 快捷方式创建成功
    echo 指向: %EDGE_EXE%
    echo 通过该快捷方式启动 Edge 即可正常设置默认浏览器
    exit /b 0
) else (
    echo 快捷方式创建失败
    pause
    exit /b 1
)
