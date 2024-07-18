require 'rails_helper'

RSpec.describe "sms_manager/sms_templates/new", type: :view do
  before(:each) do
    assign(:sms_manager_sms_template, SmsManager::SmsTemplate.new(
      :name => "MyString",
      :message => "MyText"
    ))
  end

  it "renders new sms_manager_sms_template form" do
    render

    assert_select "form[action=?][method=?]", sms_manager_sms_templates_path, "post" do

      assert_select "input[name=?]", "sms_manager_sms_template[name]"

      assert_select "textarea[name=?]", "sms_manager_sms_template[message]"
    end
  end
end
