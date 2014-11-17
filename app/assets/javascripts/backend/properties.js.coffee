ready_properties = ->

  $(".properties_rental_history #dp-ex-start").datepicker().on "changeDate", (e) ->
    $(".properties_rental_history #dp-ex-end").datepicker "setStartDate", e.date

  $(".properties_rental_history #dp-ex-end").datepicker().on "changeDate", (e) ->
    $(".properties_rental_history #dp-ex-start").datepicker "setEndDate", e.date

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