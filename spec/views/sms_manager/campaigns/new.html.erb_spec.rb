require 'rails_helper'

RSpec.describe "sms_manager/campaigns/new", type: :view do
  before(:each) do
    assign(:sms_manager_campaign, SmsManager::Campaign.new(
      :name => "MyString",
      :type => "",
      :audience => nil,
      :message => "MyText"
    ))
  end

  it "renders new sms_manager_campaign form" do
    render

    assert_select "form[action=?][method=?]", sms_manager_campaigns_path, "post" do

      assert_select "input[name=?]", "sms_manager_campaign[name]"

      assert_select "input[name=?]", "sms_manager_campaign[type]"

      assert_select "input[name=?]", "sms_manager_campaign[audience_id]"

      assert_select "textarea[name=?]", "sms_manager_campaign[message]"
    end
  end
end
