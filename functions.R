create_line = function(x1,
                       y1,
                       x2,
                       y2,
                       size,
                       type){
  
  if(type == "segment"){
    data.frame(
      x = x1,
      xend = x2,
      y = y1,
      yend = y2,
      size = size
    )
  } else if(type == "point"){
    data.frame(
      x = rep(seq(x1, x2, length.out = 10), each = 3) + runif(30, min = .00, max = .01),
      y = rep(seq(y1, y2, length.out = 10), each = 3) + runif(30, min = .00, max = .01),
      size = size
    )
  }
  
}

draw_lines = function(x_seq,
                      y_seq,
                      type){
  
  if(type == "connect"){
    size = runif(length(x_seq), min = .5, max = .75)
    purrr::map_dfr(1:(length(x_seq)-1),
                   ~create_line(x1 = x_seq[.x],
                                x2 = x_seq[.x + 1],
                                y1 = y_seq[.x],
                                y2 = y_seq[.x + 1],
                                size = size[.x],
                                type = "segment"))
  } else if(type == "adjacent"){
    
    purrr::map_dfr(1:(length(x_seq)-1),
                   ~create_line(x1 = rep(x_seq[.x], 10) - runif(10, min = 0, max = .005),
                                x2 = rep(x_seq[.x + 1], 10) - runif(10, min = 0, max = .005),
                                y1 = rep(y_seq[.x], 10) - runif(10, min = 0, max = .005),
                                y2 = rep(y_seq[.x + 1], 10) - runif(10, min = 0, max = .005),
                                size = .5,
                                type = "segment"))
  } else if(type == "disperse"){
    size = runif(length(x_seq), min = .5, max = .75)
    purrr::map_dfr(1:(length(x_seq)-1),
                   ~create_line(x1 = x_seq[.x],
                                x2 = x_seq[.x + 1],
                                y1 = y_seq[.x],
                                y2 = y_seq[.x + 1],
                                size = size[.x],
                                type = "point"))
  }
  
}