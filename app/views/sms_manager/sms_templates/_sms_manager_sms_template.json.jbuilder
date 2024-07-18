json.extract! sms_manager_sms_template, :id, :name, :message, :created_at, :updated_at
json.url sms_manager_sms_template_url(sms_manager_sms_template, format: :json)
