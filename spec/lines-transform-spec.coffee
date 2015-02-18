TextBuffer = require '../src/text-buffer'
Point = require '../src/point'

{expectValues} = require './spec-helper'

describe "LinesTransform", ->
  it "transforms the linear characters layer into a layer with regions for each line", ->
    buffer = new TextBuffer(text: "abc\ndefg\nhi")
    {charactersLayer, linesLayer} = buffer

    regions = linesLayer.getRegions()
    expect(regions.length).toBe 3
    expect(regions[0].toString()).toBe '<(0, 4):(1, 0) - "abc\\n">'
    expect(regions[1].toString()).toBe '<(0, 5):(1, 0) - "defg\\n">'
    expect(regions[2].toString()).toBe '<(0, 2):(0, 2) - "hi">'

    mappings = [
      [[0, 0], [0, 0]]
      [[0, 1], [0, 1]]
      [[0, 2], [0, 2]]
      [[0, 3], [0, 3]]
      [[0, 4], [1, 0]]
      [[0, 5], [1, 1]]
      [[0, 6], [1, 2]]
      [[0, 7], [1, 3]]
      [[0, 8], [1, 4]]
      [[0, 9], [2, 0]]
      [[0, 10], [2, 1]]
      [[0, 11], [2, 2]]
    ]

    for [charactersPoint, linesPoint] in mappings
      expect(linesLayer.fromPositionInLayer(Point(charactersPoint...), charactersLayer)).toEqual Point(linesPoint...)
