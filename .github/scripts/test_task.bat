mkdir C:\artifacts

set TEST_PHP_JUNIT=C:\artifacts\junit.out.xml
set SKIP_IO_CAPTURE_TESTS=1
set REPORT_EXIT_STATUS=1

nmake test TESTS="-j3 -q --offline --show-diff --show-slow 1000 --set-timeout 120"
