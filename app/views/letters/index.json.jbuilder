json.array!(@letters) do |letter|
  json.extract! letter, :id, :name, :body, :document
  json.url letter_url(letter, format: :json)
end
