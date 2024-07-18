json.extract! sms_manager_contact, :id, :name, :number, :created_at, :updated_at
json.url sms_manager_contact_url(sms_manager_contact, format: :json)
