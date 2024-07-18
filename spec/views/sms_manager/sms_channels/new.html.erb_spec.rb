require 'rails_helper'

RSpec.describe "sms_manager/sms_channels/new", type: :view do
  before(:each) do
    assign(:sms_manager_sms_channel, SmsManager::SmsChannel.new(
      :type => "",
      :shortcode => "MyString",
      :alphanumeric => "MyString",
      :keyword => "MyString",
      :organization => nil
    ))
  end

  it "renders new sms_manager_sms_channel form" do
    render

    assert_select "form[action=?][method=?]", sms_manager_sms_channels_path, "post" do

      assert_select "input[name=?]", "sms_manager_sms_channel[type]"

      assert_select "input[name=?]", "sms_manager_sms_channel[shortcode]"

      assert_select "input[name=?]", "sms_manager_sms_channel[alphanumeric]"

      assert_select "input[name=?]", "sms_manager_sms_channel[keyword]"

      assert_select "input[name=?]", "sms_manager_sms_channel[organization_id]"
    end
  end
end
