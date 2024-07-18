require 'rails_helper'

RSpec.describe "sms_manager/contacts/show", type: :view do
  before(:each) do
    @sms_manager_contact = assign(:sms_manager_contact, SmsManager::Contact.create!(
      :name => "Name",
      :number => "Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Number/)
  end
end
