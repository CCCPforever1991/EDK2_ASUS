@echo off

chcp 65001
set WORKSPACE=%CD%
set EDK_TOOLS_PATH=%CD%\BaseTools
set CONF_PATH=%CD%\Conf
set PACKAGES_PATH=%CD%
set BASE_TOOLS_PATH=%CD%\BaseTools\
set EDK_TOOLS_BIN=%CD%\BaseTools\Bin\win32

set ARGS=
set AS_REBUILD=
set AS_REBUILDA=
set AS_CLEAN=
if "%1"=="-h" goto Usage
if "%1"=="--help" goto Usage
:ParseArgs
if "%1"=="" goto ParseArgsEnd
if /I "%1"=="-rc" (
  set ARGS=%ARGS% Reconfig
  set AS_REBUILD=
  set AS_REBUILDA=
  set AS_CLEAN=
  goto ParseArgsEnd
)
if /I "%1"=="-fr" (
  set ARGS=%ARGS% forcerebuild
  set AS_REBUILD=
  set AS_REBUILDA=
  set AS_CLEAN=
  goto ParseArgsEnd
)
if /I "%1"=="-b" (
  set AS_REBUILD=TRUE
)
if /I "%1"=="-rb" (
  set AS_REBUILDA=TRUE
)
if /I "%1"=="-c" (
  set AS_CLEAN=TRUE
)
shift
goto ParseArgs

:ParseArgsEnd

call edksetup.bat %ARGS%

@if defined AS_CLEAN (
    build cleanall
    goto end
)

@if defined AS_REBUILDA (
    build cleanall
    build
    goto end
)

@if defined AS_REBUILD (
    build
    goto end
)

goto end

:Usage
  @echo.
  @echo  Usage: "%0 [-h | --help] [-b] [-rb] [-c] [rc] [fr]"
  @echo.
  @echo         -b        build
  @echo         -rb       rebuild
  @echo         -c        clean
  @echo         -rc       reconfig
  @echo         -fr       forcerebuild
  @echo.
  goto end

:end
set AS_CLEAN=
set AS_REBUILDA=
set AS_REBUILD=
set BUILDTARGET=
@echo on