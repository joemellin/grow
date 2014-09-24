json.array!(@ratings) do |rating|
  json.extract! rating, :id, :success
  json.url rating_url(rating, format: :json)
end
