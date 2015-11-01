$ ->
  console.log 'script loaded'
  $('.miwa-rhombus').click ->
    if $(@).hasClass('stop')
      console.log 'start'
      $(@).removeClass('stop')
    else
      console.log 'stop'
      $(@).addClass('stop')
  sushi_move_time = 3000
  sushi_move = ->
    $('.sushi').css('left', '1200px')
    console.log 'animation start'
    $('.sushi').animate(
      {
        left: '-5em'
      },
      sushi_move_time,
      'easeInOutBounce'
    )
    setTimeout(sushi_move, sushi_move_time)
  sushi_move()
