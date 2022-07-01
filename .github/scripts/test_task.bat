set ARCH=%1
set ZTS=%2
set OPCACHE=%3

mkdir C:\artifacts

if exist x64\Release set PHP_BUILD_DIR=x64\Release
if exist x64\Release_TS set PHP_BUILD_DIR=x64\Release_TS
if exist Release set PHP_BUILD_DIR=Release
if exist Release_TS set PHP_BUILD_DIR=Release_TS

echo extension_dir=%PHP_BUILD_DIR%> %PHP_BUILD_DIR%\php.ini
rem work-around for some spawned PHP processes requiring OpenSSL
echo extension=php_openssl.dll>> %PHP_BUILD_DIR%\php.ini

if "%OPCACHE%"=="1" (
    mkdir %PHP_BUILD_DIR%\test_file_cache
    echo zend_extension=php_opcache.dll>> %PHP_BUILD_DIR%\php.ini
    echo opcache.file_cache=%PHP_BUILD_DIR%\test_file_cache>> %PHP_BUILD_DIR%\php.ini
)

set TEST_PHP_JUNIT=C:\artifacts\junit-%ARCH%
if "%ZTS%"=="1" (set TEST_PHP_JUNIT=%TEST_PHP_JUNIT%-zts) else set TEST_PHP_JUNIT=%TEST_PHP_JUNIT%-nts
if "%OPCACHE%"=="1" (set TEST_PHP_JUNIT=%TEST_PHP_JUNIT%-opcache) else set TEST_PHP_JUNIT=%TEST_PHP_JUNIT%-nocache
set TEST_PHP_JUNIT=%TEST_PHP_JUNIT%.xml

set SKIP_IO_CAPTURE_TESTS=1
set REPORT_EXIT_STATUS=1
if "%OPCACHE%"=="1" set OPCACHE_OPTS=-d opcache.enable=1 -d opcache.enable_cli=1 -d opcache.protect_memory=1 -d opcache.jit_buffer_size=16M

nmake test TESTS="%OPCACHE_OPTS% -j3 -q --offline --show-diff --show-slow 1000 --set-timeout 120"

exit /b %errorlevel%
