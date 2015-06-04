--TEST--
Bug #52065 - Warning about open_basedir restriction while accessing a file as directory
--INI--
open_basedir=.
--FILE--
<?php
require_once "open_basedir.inc";
create_directories();
var_dump(file_exists('./test/ok/ok.txt/doesntexist'));
?>
--CLEAN--
<?php
require_once "open_basedir.inc";
delete_directories();
?>
--EXPECT--
bool(true)
bool(true)
bool(true)
bool(false)
