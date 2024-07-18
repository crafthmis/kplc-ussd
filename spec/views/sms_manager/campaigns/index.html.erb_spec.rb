require 'rails_helper'

RSpec.describe "sms_manager/campaigns/index", type: :view do
  before(:each) do
    assign(:sms_manager_campaigns, [
      SmsManager::Campaign.create!(
        :name => "Name",
        :type => "Type",
        :audience => nil,
        :message => "MyText"
      ),
      SmsManager::Campaign.create!(
        :name => "Name",
        :type => "Type",
        :audience => nil,
        :message => "MyText"
      )
    ])
  end

  it "renders a list of sms_manager/campaigns" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
