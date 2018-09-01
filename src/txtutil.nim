import strutils, nre, os
import subcmd/de, subcmd/startswith

proc usage() =
  let s = """
Usage: txtutil [OPTION]... PATTERN [FILE]
  -n      : repeat N times.
  -r      : remain first N islands."""
  echo s

proc run(cmd: string) =
  var remainArgs = os.commandLineParams()[1..os.commandLineParams().len-1]
  if cmd == "de":
    for line in de(remainArgs): echo line
  if cmd == "startswith":
    for line in startswith(remainArgs): echo line

if paramCount() == 0:
  usage()
  quit(0)

run(os.commandLineParams()[0])

