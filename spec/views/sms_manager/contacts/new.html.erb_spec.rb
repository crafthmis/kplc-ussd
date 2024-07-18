require 'rails_helper'

RSpec.describe "sms_manager/contacts/new", type: :view do
  before(:each) do
    assign(:sms_manager_contact, SmsManager::Contact.new(
      :name => "MyString",
      :number => "MyString"
    ))
  end

  it "renders new sms_manager_contact form" do
    render

    assert_select "form[action=?][method=?]", sms_manager_contacts_path, "post" do

      assert_select "input[name=?]", "sms_manager_contact[name]"

      assert_select "input[name=?]", "sms_manager_contact[number]"
    end
  end
end
