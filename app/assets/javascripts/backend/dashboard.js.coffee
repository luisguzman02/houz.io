ready_dashboard = ->      
  $.fn.loading = ->
    $(@).html($('#spinner').html())   

$(document).ready ->
  $.fn.bootstrapDP = $.fn.datepicker.noConflict()
  ready_dashboard()
  
$(document).on('page:load', ->
  ready_dashboard()
  CanvasAdmin.init()
)  