require 'rails_helper'

RSpec.describe "sms_channels/edit", type: :view do
  before(:each) do
    @sms_channel = assign(:sms_channel, SmsChannel.create!(
      :type => "",
      :shortcode => "MyString",
      :alphanumeric => "MyString",
      :keyword => "MyString",
      :organization => nil
    ))
  end

  it "renders the edit sms_channel form" do
    render

    assert_select "form[action=?][method=?]", sms_channel_path(@sms_channel), "post" do

      assert_select "input[name=?]", "sms_channel[type]"

      assert_select "input[name=?]", "sms_channel[shortcode]"

      assert_select "input[name=?]", "sms_channel[alphanumeric]"

      assert_select "input[name=?]", "sms_channel[keyword]"

      assert_select "input[name=?]", "sms_channel[organization_id]"
    end
  end
end
