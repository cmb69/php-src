--TEST--
Changing pcre.jit at runtime is supposed to clean the regex cache
--INI--
pcre.jit=1
--FILE--
<?php
// a pattern/subject combination that fails for pcre.jit=1,
// but succeeds for pcre.jit=0
$pattern = '/^(foo)+$/';
$subject = str_repeat("foo", 8192);

var_dump(preg_match($pattern, $subject));
ini_set('pcre.jit', 0);
var_dump(preg_match($pattern, $subject));
?>
--EXPECT--
bool(false)
int(1)
