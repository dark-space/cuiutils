import strutils, nre, os
import subcmd/de, subcmd/startswith, subcmd/endswith, subcmd/transpose, subcmd/newline, subcmd/randomize, subcmd/replace, subcmd/unique

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
  if cmd == "endswith":
    for line in endswith(remainArgs): echo line
  if cmd == "transpose":
    for line in transpose(remainArgs): echo line
  if cmd == "newline":
    echo newline(remainArgs)
  if cmd == "randomize":
    for line in randomize(remainArgs): echo line
  if cmd == "replace":
    for line in replace(remainArgs): echo line
  if cmd == "unique":
    for line in unique(remainArgs): echo line

if paramCount() == 0:
  usage()
  quit(0)

run(os.commandLineParams()[0])

