require 'rails_helper'

RSpec.describe "sms_manager/sms_channels/index", type: :view do
  before(:each) do
    assign(:sms_manager_sms_channels, [
      SmsManager::SmsChannel.create!(
        :type => "Type",
        :shortcode => "Shortcode",
        :alphanumeric => "Alphanumeric",
        :keyword => "Keyword",
        :organization => nil
      ),
      SmsManager::SmsChannel.create!(
        :type => "Type",
        :shortcode => "Shortcode",
        :alphanumeric => "Alphanumeric",
        :keyword => "Keyword",
        :organization => nil
      )
    ])
  end

  it "renders a list of sms_manager/sms_channels" do
    render
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Shortcode".to_s, :count => 2
    assert_select "tr>td", :text => "Alphanumeric".to_s, :count => 2
    assert_select "tr>td", :text => "Keyword".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
