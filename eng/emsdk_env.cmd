@echo off
echo *** .NET EMSDK path setup ***

REM emscripten (emconfigure, em++, etc)
if "%EMSDK_PATH%"=="" (
  echo %EMSDK_PATH% is empty
  exit /b 1
)
set "TOADD_PATH_EMSCRIPTEN=%EMSDK_PATH%\emscripten"
echo PATH += %TOADD_PATH_EMSCRIPTEN%
set "PATH=%TOADD_PATH_EMSCRIPTEN%;%PATH%"

REM llvm (clang, etc)
if "%DOTNET_EMSCRIPTEN_LLVM_ROOT%"=="" (
  echo %DOTNET_EMSCRIPTEN_LLVM_ROOT% is empty
  exit /b 1
)
set "TOADD_PATH_LLVM=%DOTNET_EMSCRIPTEN_LLVM_ROOT%"
if not "%TOADD_PATH_EMSCRIPTEN%"=="%TOADD_PATH_LLVM%" (
  echo PATH += %TOADD_PATH_LLVM%
  set "PATH=%TOADD_PATH_LLVM%;%PATH%"
)

REM nodejs (node)
if "%DOTNET_EMSCRIPTEN_NODE_JS%"=="" (
  echo %DOTNET_EMSCRIPTEN_NODE_JS% is empty
  exit /b 1
)
set "TOADD_PATH_NODEJS=%~dpn0"
if not "%TOADD_PATH_EMSCRIPTEN%"=="%TOADD_PATH_NODEJS%" (
  if not "%TOADD_PATH_LLVM%"=="%TOADD_PATH_NODEJS%" (
    echo PATH += %TOADD_PATH_NODEJS%
    set "PATH=%TOADD_PATH_NODEJS%;%PATH%"
  )
)

REM binaryen (wasm-opt, etc)
if "%DOTNET_EMSCRIPTEN_BINARYEN_ROOT%"=="" (
  echo %DOTNET_EMSCRIPTEN_BINARYEN_ROOT% is empty
  exit /b 1
)
set "TOADD_PATH_BINARYEN=%DOTNET_EMSCRIPTEN_BINARYEN_ROOT%\bin"
if not "%TOADD_PATH_EMSCRIPTEN%"=="%TOADD_PATH_BINARYEN%" (
  if not "%TOADD_PATH_LLVM%"=="%TOADD_PATH_BINARYEN%" (
    if not "%TOADD_PATH_NODEJS%"=="%TOADD_PATH_BINARYEN%" (
      echo PATH += %TOADD_PATH_BINARYEN%
      set "PATH=%TOADD_PATH_BINARYEN%;%PATH%"
    )
  )
)