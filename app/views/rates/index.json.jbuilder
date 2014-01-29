json.array!(@rates) do |rate|
  json.extract! rate, :id, :name, :type, :always_apply, :hold_for_return
  json.url rate_url(rate, format: :json)
end
