require 'rails_helper'

RSpec.describe "sms_manager/audiences/new", type: :view do
  before(:each) do
    assign(:sms_manager_audience, SmsManager::Audience.new(
      :name => "MyString"
    ))
  end

  it "renders new sms_manager_audience form" do
    render

    assert_select "form[action=?][method=?]", sms_manager_audiences_path, "post" do

      assert_select "input[name=?]", "sms_manager_audience[name]"
    end
  end
end
