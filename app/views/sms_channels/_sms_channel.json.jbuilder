json.extract! sms_channel, :id, :type, :shortcode, :alphanumeric, :keyword, :organization_id, :created_at, :updated_at
json.url sms_channel_url(sms_channel, format: :json)
