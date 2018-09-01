import strutils, parseopt, nre
import ../lib/io

proc startswith*(tmpArgs: openArray[string]): seq[string] =
  proc usage() =
    let s = """
  Usage: startswith [OPTION]... QUERY [FILE]
    -i      : ignore case.
    -m      : remove coloring.
    -s      : remove leading spaces."""
    echo s

  var ignore_case = false
  var monochrome = false
  var remove_space = false

  var args: seq[string] = @[]
  if tmpArgs.len > 0:
    try:
      var p = initOptParser(@tmpArgs)
      for kind, key, val in getopt(p):
        if kind == cmdArgument:
          args.add(key)
        elif (kind == cmdShortOption and key == "i"):
          ignore_case = true
        elif (kind == cmdShortOption and key == "m"):
          monochrome = true
        elif (kind == cmdShortOption and key == "s"):
          remove_space = true
        else:
          usage()
          quit(0)
    except:
      usage()
      quit(1)

  var out_lines: seq[string] = @[]
  var query = args[0]; args.delete(0)
  if ignore_case:
    query = query.toLower
  for orig_line in readLines(args):
    var l = orig_line
    if ignore_case:
      l = l.toLower
    if monochrome:
      l = l.replace(re"\[\d+m","")
    if remove_space:
      l = l.replace(re"^\s+","")
    if not l.startswith(query):
      continue
    out_lines.add(orig_line)
  return out_lines

