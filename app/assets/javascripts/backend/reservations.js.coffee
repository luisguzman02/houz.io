#AngularJS
app = angular.module("Booking", ["ngResource"])

app.config [ "$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
]

app.factory "Reservation", ["$resource", ($resource) ->
  $resource("/reservations/:id.json", {id: "@id"})
]

app.directive "ngConfirmClick", [->
  link: (scope, element, attr) ->
    msg = attr.ngConfirmClick or "Are you sure?"
    clickAction = attr.confirmedClick
    element.bind "click", (event) ->
      scope.$eval clickAction  if window.confirm(msg)
]      

@ReservationsController = ["$scope", "Reservation", ($scope, Reservation) ->
  $scope.reservations = Reservation.query()
  
  $scope.delete = (r,index) ->
    Reservation.delete r, ->
      $scope.reservations.splice index, 1

  $scope.addtoList = (id) ->
    $scope.reservations.splice(0, 0, Reservation.get({id: id}))
]

window.ReservationsNew =

  init: ->
    $(".datepicker").bootstrapDP(
      format: "yyyy/mm/dd",
      autoclose: true
      # minDate: 0      
    ).on('show', (e) ->
      
    ).on('hide', (selectedDate) ->
      $("#reservation_check_out").bootstrapDP "setStartDate", selectedDate.date if @id is 'reservation_check_in' 
    ).on 'changeDate', (e) ->
      d1 = $('#reservation_check_in').bootstrapDP('getDate')
      d2 = $('#reservation_check_out').bootstrapDP('getDate')
      # console.log d1
      # console.log d2
      if d1 isnt null and d2 isnt null
        days = Math.floor((d2.getTime() - d1.getTime()) / 86400000)
        $('#staying_field').val(days)
      ReservationsNew.load_inquiery_booking_property()  
      
      # onClose: (selectedDate) ->        
      #   $("#reservation_check_out").datepicker "option", "minDate", selectedDate  if @id is 'check_in'        
      # onSelect: (dateText, inst) ->   
      #   d1 = $('#reservation_check_in').datepicker('getDate')
      #   d2 = $('#reservation_check_out').datepicker('getDate')
      #   if d1 isnt null and d2 isnt null
      #     days = Math.floor((d2.getTime() - d1.getTime()) / 86400000)
      #     $('#staying_field').val(days)
      #   ReservationsNew.load_inquiery_booking_property()  

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

  addToAngularScope: (id) ->
    scope = angular.element($("#rsv_listing")).scope()
    scope.$apply ->
      scope.addtoList(id)

ready_reservations_home = ->  
  $(".reservations").on "click", "#new_reservation_btn, .add_tenant, .edit_notes", (e) ->
    $("#inquiery_booking .modal-body").loading()    

  $(".reservations_index").on "click", "#inquiery_booking #date_range_icon .input-group-addon", (e) ->
    e.preventDefault()        
    $("##{$(@).attr('trigger')}").bootstrapDP("show");     

  $(".reservations_index").on "click", "#reservations_remove", (e) ->
    e.preventDefault()
    $("input.rsv_selector:checkbox:checked").each ->
      alert @value        

  #$(".reservations_index").on "click", ".add_tenant", (e) ->
  #  $("#inquiery_booking .modal-body").loading()

  #$("#inquiery_booking").on "shown.bs.modal", (e) ->


#page load triggers
$(document).ready(ready_reservations_home)  
$(document).on('page:load', ->
  ready_reservations_home()
  #bootstrapAngular
  $('[ng-app]').each ->    
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])
)