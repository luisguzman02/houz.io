ready = ->
  spinner = new Spinner().spin()


$(document).ready(ready)
$(document).on('page:load', ready)