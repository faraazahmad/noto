json.extract! cell, :id, :type, :content, :output, :notebook_id, :created_at, :updated_at
json.url cell_url(cell, format: :json)
