loadTransistors = (callback) ->
  success = (data) ->
    callback(data['transistors'])

  $.get('/transistors.json', success, 'json')

jQuery ($) -> 
  paper = Raphael('container')
  zpd = new RaphaelZPD(paper, zoom: true, pan: true, drag: false)

  penny = paper.image("/images/penny.png", 600, 0, 100, 100)
  #image = paper.image("/images/transistors/sot-23.png", 20, 20,40,40)
  #image = paper.image("/images/transistors/to-220.png", 100, 0, 100, 250)

  last_x = 20
  last_y = 20
  pixels_per_mm = 100

  loadTransistors (transistors) ->
    $.each(transistors, (name) ->
      transistor = transistors[name]
      width = transistor.dimensions.width * pixels_per_mm
      height = transistor.dimensions.height * pixels_per_mm


      paper.setStart()

      image = paper.image("/images/transistors/" + name + ".png", last_x, last_y, width, height)

      line_vert = paper.rect(width + last_x + 10, last_y, 1, height)
      line_vert.attr('fill','#ddd')
      line_vert.attr('stroke','none')

      bar_top = paper.rect(width + last_x + 5, last_y, 12, 1)
      bar_top.attr('fill','#ddd')
      bar_top.attr('stroke','none')

      bar_bottom = paper.rect(width + last_x + 5, last_y + height - 2, 12, 1)
      bar_bottom.attr('fill','#ddd')
      bar_bottom.attr('stroke','none')

      text_vert = paper.text(width + last_x + 14, last_y + ( height/2 ), transistor.dimensions.height)
      text_vert.scale(0.7)
      text_vert.attr('fill','#222')
      text_vert.rotate(90)

      line_horz = paper.rect(last_x, last_y - 10, width, 1)
      line_horz.attr('fill','#ddd')
      line_horz.attr('stroke','none')

      bar_left = paper.rect(last_x, last_y - 5 - 10, 1, 12)
      bar_left.attr('fill','#ddd')
      bar_left.attr('stroke','none')

      bar_right = paper.rect(width + last_x, last_y - 5 - 10, 1, 12)
      bar_right.attr('fill','#ddd')
      bar_right.attr('stroke','none')

      text_horz = paper.text(last_x + (width/2), last_y - 14, transistor.dimensions.width)
      text_horz.scale(0.7)
      text_horz.attr('fill','#222')

      paper.setFinish()

      last_x += width + 50
    )

