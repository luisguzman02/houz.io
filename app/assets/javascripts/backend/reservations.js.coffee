window.ReservationsNew =

  init: ->
    $(".datepicker").datepicker
      dateFormat: 'yy-mm-dd'
      minDate: 0
      onClose: (selectedDate) ->        
        $("#reservation_check_out").datepicker "option", "minDate", selectedDate  if @id is 'check_in'        
      onSelect: (dateText, inst) ->        
        d1 = $('#reservation_check_in').datepicker('getDate')
        d2 = $('#reservation_check_out').datepicker('getDate')
        if d1 isnt null and d2 isnt null
          days = Math.floor((d2.getTime() - d1.getTime()) / 86400000)
          $('#staying').val(days)
        ReservationsNew.load_inquiery_booking_property()  

    $(document).on "submit", "#inquiery_booking #inquiery_booking_form", (event) ->
      $('#inquiery_booking .modal-body').loading()

  load_inquiery_booking_property: ->
    if $('#reservation_property_id').val() is '' or $('#reservation_property_id').val() is undefined
      $('#inquiery_booking_form #booking_info').html('<p>Please choose desired property</p>')
      return false

    if $('#reservation_check_in').val() isnt '' and $('#reservation_check_out').val() isnt ''
      $('#inquiery_booking_form #booking_info').loading()

      pid = $('#inquiery_booking_form #reservation_property_id').val()
      _params =
        check_in: $('#reservation_check_in').val()
        check_out: $('#reservation_check_out').val()      
      $.getJSON "/properties/#{pid}/booking_detail.json", _params, (data) ->  
        if data.error is undefined          
          $('#booking_info').html(JST["booking_info"]({property: data.property, rates: data.rates}))        
          $("#inquiery_booking_form #book_btn").attr "disabled", false 
        else
          $('#booking_info').html(data.error)        
          $("#inquiery_booking_form #book_btn").attr "disabled", true 

ready_reservations_home = ->
  $(".reservations_index").on "click", "#new_reservation_btn, .add_tenant", (e) ->
    $("#inquiery_booking .modal-body").loading()    

  $(".reservations_index").on "click", "#inquiery_booking #date_range_icon .input-group-addon", (e) ->
    e.preventDefault()
    $("##{$(@).attr('trigger')}").datepicker("show");  

  #$(".reservations_index").on "click", ".add_tenant", (e) ->
  #  $("#inquiery_booking .modal-body").loading()

  #$("#inquiery_booking").on "shown.bs.modal", (e) ->

#page load triggers
$(document).ready(ready_reservations_home)
$(document).on('page:load', ready_reservations_home)