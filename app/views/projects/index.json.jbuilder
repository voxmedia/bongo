json.array!(@projects) do |project|
  json.extract! project, :id, :title, :kit_id, :typekit_token
  json.url project_url(project, format: :json)
end
