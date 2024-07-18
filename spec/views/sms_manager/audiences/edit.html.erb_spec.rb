require 'rails_helper'

RSpec.describe "sms_manager/audiences/edit", type: :view do
  before(:each) do
    @sms_manager_audience = assign(:sms_manager_audience, SmsManager::Audience.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit sms_manager_audience form" do
    render

    assert_select "form[action=?][method=?]", sms_manager_audience_path(@sms_manager_audience), "post" do

      assert_select "input[name=?]", "sms_manager_audience[name]"
    end
  end
end
