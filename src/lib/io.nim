import strutils, nre

proc read*(files: seq[string]): string =
  if files.len < 1 or files[0] == "-":
    return readAll(stdin).replace("\r","").replace(re"\n$","")
  else:
    let f = open(files[0], FileMode.fmRead)
    defer: f.close()
    return f.readAll().replace("\r","").replace(re"\n$","")

proc read*(file: string): string =
  return read(@[file])

proc readRaw*(files: seq[string]): string =
  if files.len < 1 or files[0] == "-":
    return readAll(stdin)
  else:
    let f = open(files[0], FileMode.fmRead)
    defer: f.close()
    return f.readAll()

proc readRaw*(file: string): string =
  return readRaw(@[file])

iterator readLines*(files: seq[string]): string =
  if files.len < 1 or files[0] == "-":
    var line: string
    while stdin.readline(line):
      yield line.replace("\r","").replace(re"\n$","")
  else:
    let f = open(files[0], FileMode.fmRead)
    defer: f.close()
    var line: string
    while f.readline(line):
      yield line.replace("\r","").replace(re"\n$","")

iterator readLines*(file: string): string =
  let f = open(file, FileMode.fmRead)
  defer: f.close()
  var line: string
  while f.readline(line):
    yield line.replace("\r","").replace(re"\n$","")

iterator readLinesRaw*(files: seq[string]): string =
  if files.len < 1 or files[0] == "-":
    var line: string
    while stdin.readline(line):
      yield line.replace("\r","").replace(re"\n$","")
  else:
    let f = open(files[0], FileMode.fmRead)
    defer: f.close()
    var line: string
    while f.readline(line):
      yield line.replace("\r","").replace(re"\n$","")

iterator readLinesRaw*(file: string): string =
  let f = open(file, FileMode.fmRead)
  defer: f.close()
  var line: string
  while f.readline(line):
    yield line.replace("\r","").replace(re"\n$","")

