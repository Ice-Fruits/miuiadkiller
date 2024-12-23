@echo off
title MIUI终极去广告之免root卸载/冻结
color 2f
mode con lines=30 cols=68
REM ________________________________________________________________

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (

    echo 请求管理员权限...

    goto UACPrompt

) else ( goto gotAdmin )

:UACPrompt

    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"

    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
exit /B

:gotAdmin

    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
	goto A

REM ________________________________________________________________


:A
Rem 删除临时文件
del %TempFile_Name% 1>nul 2>nul
CLS
cd /d %~dp0
ECHO. ==============================================================
ECHO  MIUI 在很多地方加了广告(比如软件启动时，比如作业帮)，有些是可以关闭的，但有些不能。
echo.
echo  关闭不了的广告大部分是msa推送的，因此我们把它删掉。
echo.
echo  注意：目前(2023.7.6)还没有删除以后卡米现象，不保证以后没有。
ECHO.
ECHO. 首先我们需要重启adb服务
ECHO.
ECHO. 请退出手机助手类软件，然后按任意键继续
ECHO. ==============================================================
ECHO.
PAUSE>NUL
cls
ECHO. ====================================================
ECHO.
ECHO. 正在尝试重启ADB服务~
ECHO.
ECHO. ====================================================
ECHO.
echo.
adb kill-server
ping 127.0.0.1 /n 2 >nul
adb start-server
cls
ECHO.
ECHO  ==============================================================
ECHO.
echo  重启服务完毕，请确保下方设备列表中有你的设备。按任意键继续……
ECHO.
ECHO  ==============================================================
ECHO.
echo 设备列表：
adb devices
echo.
PAUSE >nul

:if1
cls
color 3f
ECHO.
ECHO  ==========选择你的MIUI系统类型,输入对应数字并回车=============
ECHO.
echo             1. 国内版本MIUI
echo             2. 国际版本MIUI
ECHO.
ECHO  ==============================================================
ECHO.
set value1=
set /p value1= 选择:
echo.
IF /I "%value1%"=="1" GOTO home
IF /I "%value1%"=="2" GOTO abroad
cls
color cf
echo.
echo.
echo 选择无效，请重新输入
echo.
ping 127.0.0.1 /n 3 >nul
goto if1

:home
cls
color 3f
ECHO.
ECHO  ============选择你要执行的操作,输入对应数字并回车==============
ECHO.
echo             1. 卸载广告 (更彻底)
echo             2. 冻结广告 (更安全)
ECHO.
ECHO  ==============================================================
ECHO.
set value2=
set /p value2= 选择:
IF /I "%value2%"=="1" GOTO homeuninstall
IF /I "%value2%"=="2" GOTO homedisable
cls
color cf
echo.
echo.
echo 选择无效，请重新输入
echo.
ping 127.0.0.1 /n 3 >nul
goto home

:homeuninstall
cls
color 3f
echo.
echo.
echo ====================命令执行结果==================
echo.
::万恶的msa
adb shell pm uninstall --user 0 com.miui.systemAdSolution
::音乐
adb shell pm uninstall --user 0 com.miui.player
::游戏中心
adb shell pm uninstall --user 0 com.xiaomi.gamecenter
::内容中心
adb shell pm uninstall --user 0 com.miui.newhome
::万象息屏（这个没有，屏下指纹无法锁屏解锁，侧边解锁的可以去除这个）
::adb shell pm uninstall --user 0 com.miui.aod
adb shell pm uninstall --user 0 com.mfashiongallery.emag
::小米健康
adb shell pm uninstall --user 0 com.mi.health
adb shell pm uninstall --user 0 com.miui.miservice
::用户反馈
adb shell pm uninstall --user 0 com.miui.bugreport
adb shell pm uninstall --user 0 com.xiaomi.ab
::快应用服务框架
adb shell pm uninstall --user 0 com.miui.hybrid
::智能助理（负一屏）（直接卸载，自己不使用）
adb shell pm uninstall --user 0 com.miui.personalassistant
::小米广告分析
adb shell pm uninstall --user 0 com.miui.analytics
::小爱建议
adb shell pm uninstall --user 0 com.xiaomi.aireco
::小爱同学
adb shell pm uninstall --user 0 com.miui.voiceassist
::小爱翻译
adb shell pm uninstall --user 0 com.xiaomi.aiasst.vision
::语音唤醒
adb shell pm uninstall --user 0 com.miui.voicetrigger
::三方应用异常分析
adb shell pm uninstall --user 0 com.miui.thirdappassistant

echo.
echo ==================================================
echo.
echo.
echo 如果看见 Success 字样即为成功。
echo.
echo 然后尽情享受吧~（万能遥控效果明显）
echo.
echo 按下任意键退出
pause>nul
exit

:homedisable
cls
color 3f
echo.
echo.
echo ====================命令执行结果==================
echo.
adb shell pm disable-user --user 0 com.miui.systemAdSolution
adb shell pm disable-user --user 0 com.miui.player
adb shell pm disable-user --user 0 com.xiaomi.gamecenter
adb shell pm disable-user --user 0 com.miui.newhome
adb shell pm disable-user --user 0 com.miui.aod
echo.
echo ==================================================
echo.
echo.
echo 如果看见 new state: disabled-user 字样即为成功。
echo.
echo 然后尽情享受吧~（万能遥控效果明显）
echo.
echo 按下任意键退出
pause>nul
exit

:abroad
cls
color 3f
ECHO.
ECHO  ============选择你要执行的操作,输入对应数字并回车==============
ECHO.
echo             1. 卸载msa (更彻底)
echo             2. 冻结msa (更安全)
ECHO.
ECHO  ==============================================================
ECHO.
set value3=
set /p value3= 选择:
IF /I "%value3%"=="1" GOTO abroaduninstall
IF /I "%value3%"=="2" GOTO abroaddisable
cls
color cf
echo.
echo.
echo 选择无效，请重新输入
echo.
ping 127.0.0.1 /n 3 >nul
goto abroad

:abroaduninstall
cls
color 3f
echo.
echo.
echo ====================命令执行结果==================
echo.
adb shell pm uninstall --user 0 com.miui.msa.global
echo.
echo ==================================================
echo.
echo.
echo 如果看见 Success 字样即为成功。
echo.
echo 然后尽情享受吧~（万能遥控效果明显）
echo.
echo 按下任意键退出
pause>nul
exit

:abroaddisable
cls
color 3f
echo.
echo.
echo ====================命令执行结果==================
echo.
adb shell pm disable-user --user 0 com.miui.msa.global
echo.
echo ==================================================
echo.
echo.
echo 如果看见 new state: disabled-user 字样即为成功。
echo.
echo 然后尽情享受吧~（万能遥控效果明显）
echo.
echo 按下任意键退出
pause>nul
exit
