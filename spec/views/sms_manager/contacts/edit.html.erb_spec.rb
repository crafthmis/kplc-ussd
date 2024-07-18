require 'rails_helper'

RSpec.describe "sms_manager/contacts/edit", type: :view do
  before(:each) do
    @sms_manager_contact = assign(:sms_manager_contact, SmsManager::Contact.create!(
      :name => "MyString",
      :number => "MyString"
    ))
  end

  it "renders the edit sms_manager_contact form" do
    render

    assert_select "form[action=?][method=?]", sms_manager_contact_path(@sms_manager_contact), "post" do

      assert_select "input[name=?]", "sms_manager_contact[name]"

      assert_select "input[name=?]", "sms_manager_contact[number]"
    end
  end
end
