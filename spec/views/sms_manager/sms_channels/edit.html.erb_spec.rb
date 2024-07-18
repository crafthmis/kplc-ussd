require 'rails_helper'

RSpec.describe "sms_manager/sms_channels/edit", type: :view do
  before(:each) do
    @sms_manager_sms_channel = assign(:sms_manager_sms_channel, SmsManager::SmsChannel.create!(
      :type => "",
      :shortcode => "MyString",
      :alphanumeric => "MyString",
      :keyword => "MyString",
      :organization => nil
    ))
  end

  it "renders the edit sms_manager_sms_channel form" do
    render

    assert_select "form[action=?][method=?]", sms_manager_sms_channel_path(@sms_manager_sms_channel), "post" do

      assert_select "input[name=?]", "sms_manager_sms_channel[type]"

      assert_select "input[name=?]", "sms_manager_sms_channel[shortcode]"

      assert_select "input[name=?]", "sms_manager_sms_channel[alphanumeric]"

      assert_select "input[name=?]", "sms_manager_sms_channel[keyword]"

      assert_select "input[name=?]", "sms_manager_sms_channel[organization_id]"
    end
  end
end
