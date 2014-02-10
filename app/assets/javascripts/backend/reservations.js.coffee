ready_reservations = ->
  $("#check_in, #check_out").datepicker
      dateFormat: 'yy-mm-dd'
      minDate: 0
      onClose: (selectedDate) ->        
        $("#check_out").datepicker "option", "minDate", selectedDate  if @id is 'check_in'        
      onSelect: (dateText, inst) ->        
        d1 = $('#check_in').datepicker('getDate')
        d2 = $('#check_out').datepicker('getDate')
        if d1 isnt null and d2 isnt null
          days = Math.floor((d2.getTime() - d1.getTime()) / 86400000)
          $('#staying').val(days)


  $(".reservations_index").on "click", "#inquiery_booking #date_range_icon .input-group-addon", (e) ->
    e.preventDefault();      
    $("##{$(@).attr('trigger')}").datepicker("show");  

calc_staying_nights = ->


$(document).ready(ready_reservations)
$(document).on('page:load', ready_reservations)