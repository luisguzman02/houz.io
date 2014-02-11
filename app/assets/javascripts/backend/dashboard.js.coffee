# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready_dashboard = ->
  $.fn.loading = ->
    $(@).html($('#spinner').html())    

$(document).ready(ready_dashboard)
$(document).on('page:load', ready_dashboard)  