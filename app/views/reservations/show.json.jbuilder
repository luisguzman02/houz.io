json.extract! @reservation, :id, :created_at, :updated_at, :tenant_info
json.property { 
  json.name @reservation.property.name    
}