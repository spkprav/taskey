json.array!(@feeds) do |feed|
  json.extract! feed, :id, :title, :description, :file, :type, :user_id
  json.url feed_url(feed, format: :json)
end
