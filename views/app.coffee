PIXELS_PER_MM = 10

setupPenny = (paper) ->
  penny = paper.image("/images/penny.png", 600, 0, 19 * PIXELS_PER_MM, 19 * PIXELS_PER_MM)
  penny.attr(cursor: 'move')
  penny.node.draggable = true

loadTransistors = (callback) ->
  success = (data) ->
    callback(data['transistors'])

  $.get('/transistors.json', success, 'json')

jQuery ($) -> 
  paper = Raphael('container')
  zpd = new RaphaelZPD(paper, zoom: true, pan: true, drag: true)

  setupPenny(paper)

  last_x = 20
  last_y = 20

  loadTransistors (transistors) ->
    $.each(transistors, (name) ->
      transistor = transistors[name]
      width = transistor.dimensions.width * PIXELS_PER_MM
      height = transistor.dimensions.height * PIXELS_PER_MM

      paper.setStart()

      image = paper.image("/images/transistors/" + name + ".png", last_x, last_y, width, height)
      image.node.draggable = false

      line_vert = paper.rect(width + last_x + 10, last_y, 1, height)
      line_vert.attr('fill','#ddd')
      line_vert.attr('stroke','none')
      line_vert.node.draggable = false

      bar_top = paper.rect(width + last_x + 5, last_y, 12, 1)
      bar_top.attr('fill','#ddd')
      bar_top.attr('stroke','none')
      bar_top.node.draggable = false

      bar_bottom = paper.rect(width + last_x + 5, last_y + height - 2, 12, 1)
      bar_bottom.attr('fill','#ddd')
      bar_bottom.attr('stroke','none')
      bar_bottom.node.draggable = false

      text_vert = paper.text(width + last_x + 14, last_y + ( height/2 ), transistor.dimensions.height)
      text_vert.scale(0.7)
      text_vert.attr('fill','#222')
      text_vert.rotate(90)
      text_vert.node.draggable = false

      line_horz = paper.rect(last_x, last_y - 10, width, 1)
      line_horz.attr('fill','#ddd')
      line_horz.attr('stroke','none')
      line_horz.node.draggable = false

      bar_left = paper.rect(last_x, last_y - 5 - 10, 1, 12)
      bar_left.attr('fill','#ddd')
      bar_left.attr('stroke','none')
      bar_left.node.draggable = false

      bar_right = paper.rect(width + last_x, last_y - 5 - 10, 1, 12)
      bar_right.attr('fill','#ddd')
      bar_right.attr('stroke','none')
      bar_right.node.draggable = false

      text_horz = paper.text(last_x + (width/2), last_y - 14, transistor.dimensions.width)
      text_horz.scale(0.7)
      text_horz.attr('fill','#222')
      text_horz.node.draggable = false

      paper.setFinish()

      last_x += width + PIXELS_PER_MM*3
    )

