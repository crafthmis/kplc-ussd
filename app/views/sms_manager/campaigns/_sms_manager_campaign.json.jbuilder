json.extract! sms_manager_campaign, :id, :name, :type, :audience_id, :message, :created_at, :updated_at
json.url sms_manager_campaign_url(sms_manager_campaign, format: :json)
