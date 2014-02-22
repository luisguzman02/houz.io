json.array!(@reservations) do |reservation|
  json.partial! reservation
end
