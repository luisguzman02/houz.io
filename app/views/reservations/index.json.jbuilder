json.array!(@reservations) do |reservation|
  json.extract! reservation, :check_in, :check_out, :tenant_info, :type_humanized
  json.id reservation.id.to_s
  json.num_nights pluralize(reservation.nights_staying, 'night')
  json.created_at reservation.created_at.to_date
  json.property { 
    json.name reservation.property.name    
  }
  json.url reservation_url(reservation)
end
