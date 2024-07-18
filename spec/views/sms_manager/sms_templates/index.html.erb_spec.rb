require 'rails_helper'

RSpec.describe "sms_manager/sms_templates/index", type: :view do
  before(:each) do
    assign(:sms_manager_sms_templates, [
      SmsManager::SmsTemplate.create!(
        :name => "Name",
        :message => "MyText"
      ),
      SmsManager::SmsTemplate.create!(
        :name => "Name",
        :message => "MyText"
      )
    ])
  end

  it "renders a list of sms_manager/sms_templates" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
