@echo off

:: Переход в папку со скриптом
cd /d "%~dp0"

set BUILD_DIR=build
set EXE_NAME=ControlModels.exe
set PLOT_SCRIPT=src/plot_results.py

echo ===================================================
echo   Build and Run Simulation (Variant 2)
echo ===================================================

:: Проверка наличия CMakeLists.txt
if not exist CMakeLists.txt (
    echo [ERROR] CMakeLists.txt not found in current directory.
    echo Please run this script from the project root.
    pause
    exit /b 1
)

:: Чистка старой сборки
if exist %BUILD_DIR% (
    echo [STEP 0] Removing old build directory...
    rmdir /s /q %BUILD_DIR%
)
mkdir %BUILD_DIR%
cd %BUILD_DIR%

:: Конфигурация CMake
echo.
echo [STEP 1/3] Configuring project via CMake...
cmake .. -DCMAKE_BUILD_TYPE=Release
if errorlevel 1 (
    echo [ERROR] CMake configuration failed.
    cd ..
    goto end
)

:: Сборка
echo.
echo [STEP 2/3] Building project modules...
cmake --build . --config Release
if errorlevel 1 (
    echo [ERROR] Compilation failed.
    cd ..
    goto end
)

:: Запуск симуляции
echo.
echo [STEP 3/3] Running simulation...
if not exist %EXE_NAME% (
    echo [ERROR] Executable '%EXE_NAME%' not found after build.
    cd ..
    goto end
)
%EXE_NAME%
if errorlevel 1 (
    echo [WARNING] Simulation exited with non-zero code.
)

:: Возврат в корень проекта
cd ..

:: Построение графика
echo.
echo ===================================================
echo Generating and opening graph...
echo ===================================================
if not exist %PLOT_SCRIPT% (
    echo [ERROR] Plot script '%PLOT_SCRIPT%' not found.
    goto end
)
py %PLOT_SCRIPT%

:end
echo.
echo ===================================================
echo Process finished. Press any key to exit.
echo ===================================================
pause >nul