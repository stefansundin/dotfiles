#!/usr/local/bin/expect -f
# brew install expect
# ./mysql_config_editor-set.sh loginpath username password

set loginpath [lindex $argv 0];
set username  [lindex $argv 1];
set password  [lindex $argv 2];

spawn mysql_config_editor set --login-path=${loginpath} --user=${username} --password
expect -nocase "Enter password:" {send "${password}\r"; interact}
