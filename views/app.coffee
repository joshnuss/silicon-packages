jQuery ($) -> 
  paper = Raphael('container')
  zpd = new RaphaelZPD(paper, zoom: true, pan: true, drag: true)

  image = paper.image("/images/penny.png", 600, 0, 100, 100)
  image = paper.image("/images/transistors/sot-23.png", 20, 20,40,40)
  image = paper.image("/images/transistors/to-220.png", 100, 0, 100, 250)
