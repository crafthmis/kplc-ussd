require 'rails_helper'

RSpec.describe "complaints/edit", type: :view do
  before(:each) do
    @complaint = assign(:complaint, Complaint.create!(
      :customer => "",
      :info => "MyString",
      :complaintable => nil
    ))
  end

  it "renders the edit complaint form" do
    render

    assert_select "form[action=?][method=?]", complaint_path(@complaint), "post" do

      assert_select "input[name=?]", "complaint[customer]"

      assert_select "input[name=?]", "complaint[info]"

      assert_select "input[name=?]", "complaint[complaintable_id]"
    end
  end
end
