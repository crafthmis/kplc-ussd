require 'rails_helper'

RSpec.describe "sms_manager/campaigns/edit", type: :view do
  before(:each) do
    @sms_manager_campaign = assign(:sms_manager_campaign, SmsManager::Campaign.create!(
      :name => "MyString",
      :type => "",
      :audience => nil,
      :message => "MyText"
    ))
  end

  it "renders the edit sms_manager_campaign form" do
    render

    assert_select "form[action=?][method=?]", sms_manager_campaign_path(@sms_manager_campaign), "post" do

      assert_select "input[name=?]", "sms_manager_campaign[name]"

      assert_select "input[name=?]", "sms_manager_campaign[type]"

      assert_select "input[name=?]", "sms_manager_campaign[audience_id]"

      assert_select "textarea[name=?]", "sms_manager_campaign[message]"
    end
  end
end
