ready = ->
  #document.addEventListener "page:fetch", ->
  #  $("#main_spinner").show()
  #document.addEventListener "page:receive", ->
  #  $("#main_spinner").hide()  

$(document).ready(ready)
$(document).on('page:load', ready)