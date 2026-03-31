@echo off
title MIUI一键去广告之免root卸载
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
ECHO  MIUI 在很多地方加了广告(比如开机动画时，比如作业帮)，有些是可以关闭的，但有些不能。
echo.
echo  关闭不了的广告大部分是msa推送的，因此我们把它删掉。
echo.
echo  注意：目前(2026.3.31)还没有删除以后卡米现象，不保证以后没有。
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
echo  重启服务完毕，请确保下方设备列表中有你的设备。按任意键继续…
ECHO.
ECHO  ==============================================================
ECHO.
echo 设备列表：
adb devices
echo.
PAUSE >nul

cls
color 3f
echo.
echo.
echo ====================命令执行结果==================
echo.
::卸载msa
adb shell pm uninstall --user 0 com.miui.systemAdSolution
::音乐
adb shell pm uninstall --user 0 com.miui.player
::游戏中心
adb shell pm uninstall --user 0 com.xiaomi.gamecenter
::内容中心
adb shell pm uninstall --user 0 com.miui.newhome
::万象息屏（如需恢复指纹解锁无法使用，建议谨慎，已注释掉）
::adb shell pm uninstall --user 0 com.miui.aod
adb shell pm uninstall --user 0 com.mfashiongallery.emag
::小米健康
adb shell pm uninstall --user 0 com.mi.health
adb shell pm uninstall --user 0 com.miui.miservice
::用户反馈
adb shell pm uninstall --user 0 com.miui.bugreport
adb shell pm uninstall --user 0 com.xiaomi.ab
::快应用框架
adb shell pm uninstall --user 0 com.miui.hybrid
::负一屏（个人助理，一般直接卸载，自己看着使用）
adb shell pm uninstall --user 0 com.miui.personalassistant
::小米统计
adb shell pm uninstall --user 0 com.miui.analytics
::小米推荐
adb shell pm uninstall --user 0 com.xiaomi.aireco
::小爱同学
adb shell pm uninstall --user 0 com.miui.voiceassist
::小爱视觉
adb shell pm uninstall --user 0 com.xiaomi.aiasst.vision
::语音触发
adb shell pm uninstall --user 0 com.miui.voicetrigger
::第三方应用异常检测
adb shell pm uninstall --user 0 com.miui.thirdappassistant
::绿色守护
adb shell pm uninstall --user 0 com.miui.greenguard
::健康数据管理
adb shell pm uninstall --user 0 com.android.healthconnect.controller
::跨屏协同
adb shell pm uninstall --user 0 com.xiaomi.mirror
::浏览器
adb shell pm uninstall --user 0 com.android.browser
::支付
adb shell pm uninstall --user 0 com.xiaomi.payment
::小米互联通信服务
adb shell pm uninstall --user 0 com.xiaomi.mi_connect_service
::设备互联
adb shell pm uninstall --user 0 com.milink.service
::小米相机AI识别
adb shell pm uninstall --user 0 com.xiaomi.aicr
::小米视频
adb shell pm uninstall --user 0 com.miui.video
::carwith
adb shell pm uninstall --user 0 com.miui.carlink
::系统分析服务
adb shell pm uninstall --user 0 com.miui.misightservice
::系统后台服务
adb shell pm uninstall --user 0 com.miui.daemon

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
