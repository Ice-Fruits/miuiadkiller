@echo off
title MIUI�ռ�ȥ���֮��rootж��/����
color 2f
mode con lines=30 cols=68
REM ________________________________________________________________

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (

    echo �������ԱȨ��...

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
Rem ɾ����ʱ�ļ�
del %TempFile_Name% 1>nul 2>nul
CLS
cd /d %~dp0
ECHO. ==============================================================
ECHO  MIUI �ںܶ�ط����˹��(�����������ʱ��������ҵ��)����Щ�ǿ��Թرյģ�����Щ���ܡ�
echo.
echo  �رղ��˵Ĺ��󲿷���msa���͵ģ�������ǰ���ɾ����
echo.
echo  ע�⣺Ŀǰ(2018.6.29)��û��ɾ���Ժ������󣬲���֤�Ժ�û�С�
ECHO.
ECHO. ����������Ҫ����adb����
ECHO.
ECHO. ���˳��ֻ������������Ȼ�����������
ECHO. ==============================================================
ECHO.
PAUSE>NUL
cls
ECHO. ====================================================
ECHO.
ECHO. ���ڳ�������ADB����~
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
echo  ����������ϣ���ȷ���·��豸�б���������豸�����������������
ECHO.
ECHO  ==============================================================
ECHO.
echo �豸�б�
adb devices
echo.
PAUSE >nul

:if1
cls
color 3f
ECHO.
ECHO  ==========ѡ�����MIUIϵͳ����,�����Ӧ���ֲ��س�=============
ECHO.
echo             1. ���ڰ汾MIUI
echo             2. ���ʰ汾MIUI
ECHO.
ECHO  ==============================================================
ECHO.
set value1=
set /p value1= ѡ��:
echo.
IF /I "%value1%"=="1" GOTO home
IF /I "%value1%"=="2" GOTO abroad
cls
color cf
echo.
echo.
echo ѡ����Ч������������
echo.
ping 127.0.0.1 /n 3 >nul
goto if1

:home
cls
color 3f
ECHO.
ECHO  ============ѡ����Ҫִ�еĲ���,�����Ӧ���ֲ��س�==============
ECHO.
echo             1. ж�ع�� (������)
echo             2. ������ (����ȫ)
ECHO.
ECHO  ==============================================================
ECHO.
set value2=
set /p value2= ѡ��:
IF /I "%value2%"=="1" GOTO homeuninstall
IF /I "%value2%"=="2" GOTO homedisable
cls
color cf
echo.
echo.
echo ѡ����Ч������������
echo.
ping 127.0.0.1 /n 3 >nul
goto home

:homeuninstall
cls
color 3f
echo.
echo.
echo ====================����ִ�н��==================
echo.
::����msa
adb shell pm uninstall --user 0 com.miui.systemAdSolution
::����
adb shell pm uninstall --user 0 com.miui.player
::��Ϸ����
adb shell pm uninstall --user 0 com.xiaomi.gamecenter
::��������
adb shell pm uninstall --user 0 com.miui.newhome
::����Ϣ��
adb shell pm uninstall --user 0 com.miui.aod
adb shell pm uninstall --user 0 com.mfashiongallery.emag
::С�׽���
adb shell pm uninstall --user 0 com.mi.health
adb shell pm uninstall --user 0 com.xiaomi.vipaccount
adb shell pm uninstall --user 0 com.miui.miservice
adb shell pm uninstall --user 0 com.miui.bugreport
adb shell pm uninstall --user 0 com.xiaomi.ab
echo.
echo ==================================================
echo.
echo.
echo ������� Success ������Ϊ�ɹ���
echo.
echo Ȼ�������ܰ�~������ң��Ч�����ԣ�
echo.
echo ����������˳�
pause>nul
exit

:homedisable
cls
color 3f
echo.
echo.
echo ====================����ִ�н��==================
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
echo ������� new state: disabled-user ������Ϊ�ɹ���
echo.
echo Ȼ�������ܰ�~������ң��Ч�����ԣ�
echo.
echo ����������˳�
pause>nul
exit

:abroad
cls
color 3f
ECHO.
ECHO  ============ѡ����Ҫִ�еĲ���,�����Ӧ���ֲ��س�==============
ECHO.
echo             1. ж��msa (������)
echo             2. ����msa (����ȫ)
ECHO.
ECHO  ==============================================================
ECHO.
set value3=
set /p value3= ѡ��:
IF /I "%value3%"=="1" GOTO abroaduninstall
IF /I "%value3%"=="2" GOTO abroaddisable
cls
color cf
echo.
echo.
echo ѡ����Ч������������
echo.
ping 127.0.0.1 /n 3 >nul
goto abroad

:abroaduninstall
cls
color 3f
echo.
echo.
echo ====================����ִ�н��==================
echo.
adb shell pm uninstall --user 0 com.miui.msa.global
echo.
echo ==================================================
echo.
echo.
echo ������� Success ������Ϊ�ɹ���
echo.
echo Ȼ�������ܰ�~������ң��Ч�����ԣ�
echo.
echo ����������˳�
pause>nul
exit

:abroaddisable
cls
color 3f
echo.
echo.
echo ====================����ִ�н��==================
echo.
adb shell pm disable-user --user 0 com.miui.msa.global
echo.
echo ==================================================
echo.
echo.
echo ������� new state: disabled-user ������Ϊ�ɹ���
echo.
echo Ȼ�������ܰ�~������ң��Ч�����ԣ�
echo.
echo ����������˳�
pause>nul
exit