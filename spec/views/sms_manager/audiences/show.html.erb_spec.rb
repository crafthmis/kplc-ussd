require 'rails_helper'

RSpec.describe "sms_manager/audiences/show", type: :view do
  before(:each) do
    @sms_manager_audience = assign(:sms_manager_audience, SmsManager::Audience.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
