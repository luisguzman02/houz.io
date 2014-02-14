ready_dashboard = ->
  $.fn.loading = ->
    $(@).html($('#spinner').html())    

$(document).ready(ready_dashboard)
$(document).on('page:load', ready_dashboard)  