json.array!(@time_tables) do |time_table|
  json.extract! time_table, :id, :title, :description, :start, :end, :privacy, :user_id
  json.url time_table_url(time_table, format: :json)

  json.user do
    json.id time_table.user.id
    json.name time_table.user.name
    json.avatar time_table.user.avatar.url(:thumb)
  end
end
