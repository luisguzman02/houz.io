ready_reservations = ->
  $(".reservations_index").on "click", "#head_right #new_reservation_btn", (e) ->
    e.preventDefault()
    alert 'new rsv'

$(document).ready(ready_reservations)
$(document).on('page:load', ready_reservations)