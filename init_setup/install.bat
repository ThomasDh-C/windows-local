@echo off
echo Installing Miniconda...

:: Download Miniconda
curl -o miniconda.exe https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe

:: Install Miniconda silently
start /wait "" miniconda.exe /S /D=C:\Miniconda3

:: Initialize conda for batch scripts
call C:\Miniconda3\Scripts\activate.bat

:: Create omniagent environment and install pyautogui
call conda create -n omniagent python=3.9 -y
call conda activate omniagent
call conda install -c conda-forge pyautogui -y

:: Create startup script
echo @echo off > "C:\Users\Docker\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\start_omniagent.bat"
echo call C:\Miniconda3\Scripts\activate.bat >> "C:\Users\Docker\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\start_omniagent.bat"
echo call conda activate omniagent >> "C:\Users\Docker\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\start_omniagent.bat"
echo python C:\omniagent\main.py >> "C:\Users\Docker\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\start_omniagent.bat"

:: Cleanup
del miniconda.exe

echo Setup complete! 