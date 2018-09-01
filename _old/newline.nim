import strutils, parseopt, nre
import lib/io

var args: seq[string] = @[]

proc usage() =
  let s = """
Usage: newline [OPTION]... [FILE]
  -r=<str>: replace newlines.
  -l=<int>: put N leading newlines.
  -t=<int>: put N trailing newlines.
  -z      : remove all tail newlines."""
  echo s

var subst: string
var leadN = -1
var trailN = -1
try:
  for kind, key, val in getopt():
    if kind == cmdArgument:
      args.add(key)
    elif kind == cmdShortOption and key == "r":
      subst = val
    elif kind == cmdShortOption and key == "l":
      leadN = val.parseInt
    elif kind == cmdShortOption and key == "t":
      trailN = val.parseInt
    elif kind == cmdShortOption and key == "z":
      trailN = 0
    else:
      usage()
      quit(0)
except:
  usage()
  quit(1)

var str = readRaw(args)
if leadN >= 0:
  str = str.replace(re"^\s+","")
  for i in 1 .. leadN:
    str = "\n" & str
if trailN >= 0:
  str = str.replace(re"\s+$","")
  for i in 1 .. trailN:
    str &= "\n"
if subst != nil:
  subst = subst.replace(re"([^\\])\\n", "\1\n")
  str = str.replace("\n",subst)
stdout.write(str.replace("\r","\\r"))

