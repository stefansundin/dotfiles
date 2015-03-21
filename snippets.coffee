# function getElementByXpath(path) { return document.evaluate(path, document, null, 9, null).singleNodeValue; }

# "0:10, 2:10" => ["0:10","2:10"]
["0:10, 2:10"].split(",").map (s) -> s.trim()

# pad(2) = "02"
pad = (n) ->
  ("0"+n).slice(-2)

# &amp;&#8364; = &€
decodeEntities = (str) ->
  e = document.createElement('div')
  e.innerHTML = str
  if e.childNodes.length > 0
    e.childNodes[0].nodeValue
  else
    ''

# \u4e20\u4e21\u4e22\u4e23 = 丠両丢丣
unescapeUnicode = (str) ->
  str.replace /\\u([\da-f]{4})/gi, (str, p1) ->
    String.fromCharCode(parseInt(p1, 16))

# \\[bfnrtv0/"]
unescapeLiterals = (str) ->
  str = str.replace /\\u([\da-f]{4})/gi, (str, p1) ->
    String.fromCharCode parseInt(p1, 16)
  str.replace(/\\n/g,'\n').replace(/\\"/g,'"').replace(new RegExp('\\\\/','g'),'/')

# 2056776401.50 = 2,056,776,401.50
humanizeNumber = (n) ->
  n = n.toString()
  while true
    n2 = n.replace /(\d)(\d{3})($|,|\.)/g, '$1,$2$3'
    if n == n2 then break else n = n2
  n

# insertAfter
insertAfter = (insert, after) ->
  after.parentNode.insertBefore(insert, after.nextSibling)

# remove all children
el.removeChild(el.firstChild) while el.hasChildNodes()

# fmt_filesize(1369088) = "1.3 MB"
fmt_filesize = (bytes) ->
  units = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  i = 0
  while bytes > 1024 and i < units.length
    bytes = bytes / 1024
    i++
  size = if i > 0 then bytes.toFixed(1) else bytes
  "#{size} #{units[i]}`"

# is child a child of parent?
isChildOf = (child, parent) ->
  while child != null
    return true if child == parent
    child = child.parentNode
  return false
