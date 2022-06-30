set TEST_PHP_JUNIT=C:\artifacts\junit.out.xml

nmake test TESTS="-j3 -q --offline --show-diff --show-slow 1000 --set-timeout 120"
