#!/bin/bash

# send \"\n\";
# Used to skip gdb's welcome screen when 'spawn gdb' in some versions.
# Extra newlines should not cause errors in other versions of gdb.
# 'spawn gdb -q attach $1' does not need this line

expect -c "
  spawn gdb
  send \"\n\";
  expect {
    \"gdb\" {send \"file $1\n\";}
  }
  expect {
    \"gdb\" {send \"set follow-fork-mode $2\n\";}
  }
  expect {
    \"gdb\" {send \"$3\n\";}
  }
  expect {
    \"gdb\" {send \"set pagination off\n\";}
  }
  expect {
    \"gdb\" {send \"b $4\n\";}
  }
  expect {
    \"gdb\" {send \"commands\n\";}
  }
  expect {
    \">\" {send \"silent\n\"}
  }
  expect {
    \">\" {send \"r $5\n\"}
  }
  expect {
    \">\" {send \"cont\n\"}
  }
  expect {
    \">\" {send \"end\n\"}
  }
  expect {
    \"gdb\" {send \"r $6\n\";}
  }

  while {1} {
      expect {
          timeout {
              send \"Keepalive\\r\"
          }
      }
  }
"

# 'interact' in old version of expect will cause gdb to quit.
# use 'while {1}{...}' to avoid quit gdb
