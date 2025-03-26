@echo off

REM 別フォルダをローカルフォルダに保存
REM ワールドのidって書いているところは適当な英数字なら何でもいい（と思う）、既存のワールドidとは被らないように割り当てる
robocopy "ワールドを保存しているフォルダのPATH" "C:\Users\ユーザー名\AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\minecraftWorlds\ワールドのid" /mir

REM minecraftを立ち上げる、BE版はexeファイルを開くとかではないことに注意
start shell:AppsFolder\Microsoft.MinecraftUWP_8wekyb3d8bbwe!App

REM minecraftが終了するまで5秒間ループで無理やり待機
REM 待機している間にタスクが強制終了されたら保存ができない
:wait_loop
timeout /t 5 >nul
tasklist | find /i "Minecraft.windows.exe" >nul
if not errorlevel 1 goto wait_loop

REM 重要なワールドデータを変なデータで上書きしないよう一応バックアップ
robocopy "ワールドを保存しているフォルダのPATH" "バックアップフォルダのPATH" /mir

REM ワールドデータを保存
robocopy "C:\Users\ユーザー名\AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\minecraftWorlds\ワールドのid" "ワールドを保存しているフォルダのPATH" /mir
