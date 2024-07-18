require 'rails_helper'

RSpec.describe "sms_manager/audiences/index", type: :view do
  before(:each) do
    assign(:sms_manager_audiences, [
      SmsManager::Audience.create!(
        :name => "Name"
      ),
      SmsManager::Audience.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of sms_manager/audiences" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
