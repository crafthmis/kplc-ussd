require 'rails_helper'

RSpec.describe "sms_manager/campaigns/show", type: :view do
  before(:each) do
    @sms_manager_campaign = assign(:sms_manager_campaign, SmsManager::Campaign.create!(
      :name => "Name",
      :type => "Type",
      :audience => nil,
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
