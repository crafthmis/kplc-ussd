require 'rails_helper'

RSpec.describe "complaints/show", type: :view do
  before(:each) do
    @complaint = assign(:complaint, Complaint.create!(
      :customer => "",
      :info => "Info",
      :complaintable => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Info/)
    expect(rendered).to match(//)
  end
end
