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

  load_inquiery_booking_property()

load_inquiery_booking_property = ->
  if $('property_id').val() is ''
    $('#inquiery_booking_form #booking_info').html('<p>Please choose desired property</p>')

  if $('#check_in').val() isnt '' and $('#check_in').val() isnt ''
    $('#inquiery_booking_form #booking_info').loading()

    # $.getJSON '', _params, (data) ->

$(document).ready(ready_reservations)
$(document).on('page:load', ready_reservations)