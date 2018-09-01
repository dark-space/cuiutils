import strutils, nre, os
import subcmd/de, subcmd/startswith

proc usage() =
  let s = """
Usage: strutil [OPTION]... PATTERN [FILE]
  -n      : repeat N times.
  -r      : remain first N islands."""
  echo s

proc checkInputLines(args: openArray[string]): bool =
  if args.len < 1 or args[0] == "-":
    let str = stdin.readAll
    let newline = str.find("\n")
    if newline == -1:
      return true
    return str[newline+1 .. str.len-1].contains(re"^\s*$")
  else:
    let f = open(args[0], FileMode.fmRead)
    defer: f.close()
    let str = f.readAll
    let newline = str.find("\n")
    if newline == -1:
      return true
    return str[newline+1 .. str.len-1].contains(re"^\s*$")

proc run(cmd: string) =
  var remainArgs = os.commandLineParams()[1..os.commandLineParams().len-1]
  if cmd == "startswith":
    if startswith(remainArgs).len > 0: quit(0)
    else: quit(1)

if paramCount() == 0:
  usage()
  quit(0)

#if not checkInputLines(os.commandLineParams()[1..os.commandLineParams().len-1]):
  #stderr.writeline("[Error] Multiple lines.")
  #quit(1)

run(os.commandLineParams()[0])

