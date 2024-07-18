require 'rails_helper'

RSpec.describe "sms_manager/sms_channels/show", type: :view do
  before(:each) do
    @sms_manager_sms_channel = assign(:sms_manager_sms_channel, SmsManager::SmsChannel.create!(
      :type => "Type",
      :shortcode => "Shortcode",
      :alphanumeric => "Alphanumeric",
      :keyword => "Keyword",
      :organization => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Shortcode/)
    expect(rendered).to match(/Alphanumeric/)
    expect(rendered).to match(/Keyword/)
    expect(rendered).to match(//)
  end
end
