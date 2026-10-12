@echo off
REM ===================================================================
REM CursorConcept - Windows 安装脚本
REM
REM 将本仓库 win\ 下每个配色方案的 Install.inf 依次执行。
REM 每个 Install.inf:
--   1) 把 base/*.cur 拷贝到 %SystemRoot%\Cursors\<方案名>\
--   2) 把 busy.ani / working.ani 拷贝到同目录
--   3) 写入注册表，注册一个 Windows 光标方案
--
REM 用法：
REM   install.cmd            安装所有 dark + light 配色（10 种 spinner × 2 tone = 20 个）
REM   install.cmd dark       只安装深色
REM   install.cmd light      只安装浅色
REM
REM 需要以管理员身份运行（写入 %SystemRoot%\Cursors 与 HKCU 注册表）。
REM 参考实现来源：
REM   Windows-11-Cursor-Concept-Pro-v2.0\Install_Alt_Run-As-Admin.cmd
REM ===================================================================

setlocal EnableExtensions

REM 默认安装全部
set "MODE=%~1"
if "%MODE%"=="" set "MODE=all"

REM 切到脚本所在目录（win\），让相对路径生效
pushd "%~dp0"

REM 收集所有 Install.inf。/r 递归遍历子目录。
set "COUNT=0"
for /r %%F in (Install.inf) do (
    set "INF=%%F"

    REM 根据路线属于 dark 还是 light 过滤
    echo %%F | findstr /I /C:"\dark\" >nul && set "TONE=dark"
    echo %%F | findstr /I /C:"\light\" >nul && set "TONE=light"

    if /I "%MODE%"=="all" (
        call :install_one "%%F"
    ) else if /I "%MODE%"=="%TONE%" (
        call :install_one "%%F"
    )
)

popd
echo.
echo ============================================
echo  安装完成，共处理 %COUNT% 个配色方案。
echo  请到 "设置 → 个性化 → 主题 → 鼠标光标" 选择方案。
echo  （方案名形如 W11 Cursors Dark HDPI default by Jepri Creations）
echo ============================================
endlocal
exit /b 0

:install_one
set "INF=%~1"
echo.
echo [安装] %INF%
rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 132 "%INF%"
if errorlevel 1 (
    echo   !! 失败，请确认以管理员身份运行。
) else (
    set /a "COUNT+=1" >nul
)
goto :eof