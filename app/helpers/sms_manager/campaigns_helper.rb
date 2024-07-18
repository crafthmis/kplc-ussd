module SmsManager::CampaignsHelper

def sti_campaign_path(type = "campaign", campaign = nil, action = nil)
  send "#{format_sti(action, type, campaign)}_path", campaign
end

def format_sti(action, type, campaign)
  action || campaign ? "#{format_action(action)}#{type.underscore}" : "sms_manager_#{type.underscore.pluralize}"
end

def format_action(action)
  action ? "#{action}_sms_manager_" : ""
end




end
