require 'rails_helper'

RSpec.describe "sms_manager/contacts/index", type: :view do
  before(:each) do
    assign(:sms_manager_contacts, [
      SmsManager::Contact.create!(
        :name => "Name",
        :number => "Number"
      ),
      SmsManager::Contact.create!(
        :name => "Name",
        :number => "Number"
      )
    ])
  end

  it "renders a list of sms_manager/contacts" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Number".to_s, :count => 2
  end
end
