json.array!(@rates) do |rate|
  json.partial! rate
end
