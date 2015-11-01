$ ->
  console.log 'script loaded'
  $('.miwa-rhombus').click ->
    if $(@).hasClass('stop')
      console.log 'start'
      $(@).removeClass('stop')
    else
      console.log 'stop'
      $(@).addClass('stop')
