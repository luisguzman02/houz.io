json.array!(@reservations) do |reservation|
  json.extract! reservation, :created_at, :check_in, :check_out, :staying_info, :tenant_info, :type_humanized
  json.id reservation.id.to_s
  json.property { 
    json.name reservation.property.name    
  }
  json.url reservation_url(reservation, format: :json)
end
