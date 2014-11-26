window.Properties =

  init: ->
    $("#property_booking_form .input-daterange").datepicker(
      format: "yyyy/mm/dd",
      # minDate: 0      
    ).on('show', (e) ->
      
    ).on('hide', (selectedDate) ->
      $("#reservation_check_out").datepicker "setStartDate", selectedDate.date if @id is 'reservation_check_in' 
    ).on 'changeDate', (e) ->
      d1 = $('#reservation_check_in').datepicker('getDate')
      d2 = $('#reservation_check_out').datepicker('getDate')
      # console.log d1
      # console.log d2
      if d1 isnt null and d2 isnt null
        days = Math.floor((d2.getTime() - d1.getTime()) / 86400000)
        $('#staying_field').val(days)
      Properties.load_booking_property()

    $(document).on "submit", "#inquiery_booking #property_booking_form", (event) ->
      $('#inquiery_booking .modal-body').loading()

  load_booking_property: ->
    # Show booking details with rates : Add new Booking popup
    if $('#reservation_check_in').val() isnt '' and $('#reservation_check_out').val() isnt ''
      $('#property_booking_form #booking_info').loading()

      pid = $('#property_booking_form #reservation_property_id').val()
      _params =
        check_in: $('#reservation_check_in').val()
        check_out: $('#reservation_check_out').val()      
      $.getJSON "/properties/#{pid}/booking_detail.json", _params, (data) ->  
        if data.error is undefined          
          $('#booking_info').html(JST["booking_info"]({property: data.property, rates: data.rates}))        
          $("#property_booking_form #book_btn").attr "disabled", false 
        else
          $('#booking_info').html(data.error)        
          $("#property_booking_form #book_btn").attr "disabled", true 

ready_properties = ->

  # Popup Gallery : Pictures section
  $(".ui-lightbox-gallery").magnificPopup
    delegate: "a"
    type: "image"
    tLoading: "Loading image #%curr%..."
    mainClass: "mfp-img-mobile"
    gallery:
      enabled: true
      navigateByImgClick: true
    image:
      titleSrc: "title"
      tError: "<a href=\"%url%\">The image #%curr%</a> could not be loaded."

  # Datepickers : Rental History section
  $(".properties_rental_history #dp-ex-start").datepicker().on "changeDate", (e) ->
    $(".properties_rental_history #dp-ex-end").datepicker "setStartDate", e.date

  $(".properties_rental_history #dp-ex-end").datepicker().on "changeDate", (e) ->
    $(".properties_rental_history #dp-ex-start").datepicker "setEndDate", e.date

  # Tagging : Property New / Edit
  $("#property_tags").tokenInput "/properties/tags.json",
    crossDomain: false
    prePopulate: $("#property_tags").data("pre")
    theme: "facebook"
    preventDuplicates: true
    noResultsText: "Press enter to add the tag."
    hintText: "Type your tag"
    minChars: 2

  $("#token-input-property_tags").on "keypress", (e) ->    
    if e.which is 13 and @value isnt ""
      e.preventDefault()
      $("#property_tags").tokenInput("add", {id: @value, name: @value})         


$(document).ready(ready_properties)
$(document).on('page:load', ready_properties)  