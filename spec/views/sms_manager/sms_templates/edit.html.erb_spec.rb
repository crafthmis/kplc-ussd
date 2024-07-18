require 'rails_helper'

RSpec.describe "sms_manager/sms_templates/edit", type: :view do
  before(:each) do
    @sms_manager_sms_template = assign(:sms_manager_sms_template, SmsManager::SmsTemplate.create!(
      :name => "MyString",
      :message => "MyText"
    ))
  end

  it "renders the edit sms_manager_sms_template form" do
    render

    assert_select "form[action=?][method=?]", sms_manager_sms_template_path(@sms_manager_sms_template), "post" do

      assert_select "input[name=?]", "sms_manager_sms_template[name]"

      assert_select "textarea[name=?]", "sms_manager_sms_template[message]"
    end
  end
end
