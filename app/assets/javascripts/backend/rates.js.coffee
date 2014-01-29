# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  start_ = $('#rate_start_season').val().split('-')
  end_ = $('#rate_end_season').val().split('-')
  start_date = new Date(start_[0], (start_[1]-1), start_[2], 0, 0, 0, 0)
  end_date = new Date(end_[0], (end_[1]-1), end_[2], 23, 59, 59, 59)
  both = {
    s:start_date.getTime(),
    e:end_date.getTime(),
    clear:true
  }
  $(".datepicker_range").datepicker
    dateFormat: 'yy-mm-dd'    
    numberOfMonths: 2
    defaultDate: start_date
    onSelect: (dateText, inst) ->
      d1 = new Date(inst.selectedYear, inst.selectedMonth, inst.selectedDay)
      if both.clear
        both.s = both.e = -1 
        both.clear = false
      if both.s is -1
        $("#rate_start_season").val dateText  
        both.s = both.e = d1.getTime()          
      else if both.e is both.s      
        $("#rate_end_season").val dateText                      
        both.e = d1.getTime()
        both.clear = true

    beforeShowDay: (date) ->      
      day_selected = (date.getTime() >= Math.min(both.s, both.e) and date.getTime() <= Math.max(both.s, both.e))       
      [true, ((if day_selected then "date-range-selected" else "")), '']
  
  $(".rates").on "click", "#rate_seasonable", (e) ->
    if $(@).is(':checked')
      $(".datepicker_range").show()
    else
      $(".datepicker_range").hide()

  #document.addEventListener "page:fetch", ->
  #  $("#main_spinner").show()
  #document.addEventListener "page:receive", ->
  #  $("#main_spinner").hide()  

$(document).ready(ready)
$(document).on('page:load', ready)