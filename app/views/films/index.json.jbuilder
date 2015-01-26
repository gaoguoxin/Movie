json.array!(@films) do |film|
  json.extract! film, :id, :title, :task_url, :status
  json.url film_url(film, format: :json)
end
