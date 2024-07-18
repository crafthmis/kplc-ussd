require 'rails_helper'

RSpec.describe "sms_manager/sms_templates/show", type: :view do
  before(:each) do
    @sms_manager_sms_template = assign(:sms_manager_sms_template, SmsManager::SmsTemplate.create!(
      :name => "Name",
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
