# @requires canvas, rna/RNA

now = -> (new Date()).getTime()
rope = new RNA {x: 100, y: 60}, "GCUCUAAAAGAGAG"

console.log canvas

setUp = ->
  canvas.clear()
  _.each rope.fabricObjects,  (o) -> canvas.add o

setUp()

firstStep = lastStep = now()

firstSelection = null
canvas.observe 'object:selected', (e) ->
  if !firstSelection
    firstSelection = e.target.obj
    firstSelection?.select()
  else
    secondSelection = e.target.obj
    if firstSelection == secondSelection or firstSelection.pair == secondSelection
      firstSelection.unpair()
    else
      firstSelection.makePair(secondSelection)

    firstSelection.unselect()
    firstSelection = null

  canvas.deactivateAll()


setInterval ->
  thisStep = now()
  steps = (thisStep - lastStep)

  # If you change tabs, steps can be a bajillion. Don't let that
  # happen.
  if steps > 50
    lastStep = thisStep
    return

  canvas.renderAll()
  lastStep = thisStep
  rope.step(steps)
  rope.update()

  if (thisStep - firstStep) % 1000 < 11
    console.log "tick"
, 10
