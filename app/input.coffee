
keyMap =
  enter: 13
  left: 37
  right: 39
  up: 38
  down: 40
  w: 87
  a: 65
  s: 83
  d: 68
  space: 32
  enter: 13

keysPressed = []

window.addEventListener "keydown", (e) ->
  e = e or event
  keysPressed[e.keyCode] = true

window.addEventListener "keyup", (e) ->
  e = e or event
  keysPressed[e.keyCode] = false

@isKeyDown = (name) ->
  code = keyMap[name]
  keysPressed[code]

@anyKeysDown = (names...) ->
  _.any names, isKeyDown
