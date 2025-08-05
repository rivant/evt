json.extract! connection, :id, :user_id, :relation, :first_name, :last_name, :middle_name, :email, :phone, :created_at, :updated_at
json.url connection_url(connection, format: :json)
