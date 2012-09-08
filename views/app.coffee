PIXELS_PER_MM = 10

setupPenny = (paper) ->
  size = 19 * PIXELS_PER_MM
  x = $(window).width() - size - 100 
  y = 100
  penny = paper.image("/images/penny.png", x, y, size, size)
  penny.attr(cursor: 'move')
  penny.node.draggable = true

loadTransistors = (callback) ->
  success = (data) ->
    callback(data['transistors'])

  $.get('/transistors.json', success, 'json')

addDimension = (line, bar1, bar2, text) ->
  line.attr(fill: '#ddd', stroke: 'none')
  line.node.draggable = false

  bar1.attr(fill: '#ddd', stroke: 'none')
  bar1.node.draggable = false

  bar2.attr(fill: '#ddd', stroke: 'none')
  bar2.node.draggable = false

  text.scale(0.8)
  text.attr('fill','#222', 'font-size': '12px')
  text.node.draggable = false

addHorizontalDimension = (paper, x, y, width, dimension)->
  line  = paper.rect(x, y, width, 1)
  left  = paper.rect(x, y - 5, 1, 12)
  right = paper.rect(width + x, y - 5, 1, 12)
  text  = paper.text(x + (width/2), y-5, dimension + "mm")

  addDimension(line, left, right, text)

addVerticalDimension = (paper, x, y, height, dimension)->
  line   = paper.rect(x + 10, y, 1, height)
  top    = paper.rect(x + 5, y, 12, 1)
  bottom = paper.rect(x + 5, y + height - 2, 12, 1)
  text   = paper.text(x + 18, y + ( height/2 ), dimension + "mm")

  text.rotate(90)

  addDimension(line, top, bottom, text)

jQuery ($) -> 
  paper = Raphael('container')
  zpd = new RaphaelZPD(paper, zoom: true, pan: true, drag: true)

  setupPenny(paper)

  last_x = 20
  last_y = 20
  max_height = 0

  loadTransistors (transistors) ->
    $.each(transistors, (name) ->
      transistor = transistors[name]
      width = transistor.dimensions.width * PIXELS_PER_MM
      height = transistor.dimensions.height * PIXELS_PER_MM
      max_height = height if height > max_height

      paper.setStart()

      image = paper.image("/images/transistors/" + name + ".png", last_x, last_y, width, height)
      image.node.draggable = false

      addVerticalDimension(paper, last_x+width, last_y, height, transistor.dimensions.width)
      addHorizontalDimension(paper, last_x, last_y-10, width, transistor.dimensions.width)

      text_name = paper.text(last_x + (width/2), last_y + height + 20, name.toUpperCase())
      text_name.attr(fill: '#888')
      text_box = text_name.getBBox()
      scale_factor = width/text_box.width
      text_name.scale(scale_factor-0.3)

      st = paper.setFinish()
      st.mouseover ->
        text_name.animate({fill: '#222'}, 200)
      st.mouseout ->
        text_name.animate({fill: '#888'}, 200)

      last_x += width + PIXELS_PER_MM*3
    )

    paper.setSize($('#container').width(), max_height + 100)

