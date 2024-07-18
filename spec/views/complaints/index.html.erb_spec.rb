require 'rails_helper'

RSpec.describe "complaints/index", type: :view do
  before(:each) do
    assign(:complaints, [
      Complaint.create!(
        :customer => "",
        :info => "Info",
        :complaintable => nil
      ),
      Complaint.create!(
        :customer => "",
        :info => "Info",
        :complaintable => nil
      )
    ])
  end

  it "renders a list of complaints" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Info".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
