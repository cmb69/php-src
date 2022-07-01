mkdir C:\artifacts

if exist x64\Release set PHP_BUILD_DIR=x64\Release
if exist x64\Release_TS set PHP_BUILD_DIR=x64\Release_TS
if exist Release set PHP_BUILD_DIR=Release
if exist Release_TS set PHP_BUILD_DIR=Release_TS

echo extension_dir=%PHP_BUILD_DIR%> %PHP_BUILD_DIR%\php.ini
rem work-around for some spawned PHP processes requiring OpenSSL
echo extension=php_openssl.dll>> %PHP_BUILD_DIR%\php.ini

set TEST_PHP_JUNIT=C:\artifacts\junit.out.xml
set SKIP_IO_CAPTURE_TESTS=1
set REPORT_EXIT_STATUS=1

nmake test TESTS="-j3 -q --offline --show-diff --show-slow 1000 --set-timeout 120"

exit /b %errorlevel%
