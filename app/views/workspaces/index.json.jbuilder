json.array!(@workspaces) do |workspace|
  json.extract! workspace, :id, :title
  json.url workspace_url(workspace, format: :json)
end
