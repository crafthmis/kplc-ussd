require 'rails_helper'

RSpec.describe "complaints/new", type: :view do
  before(:each) do
    assign(:complaint, Complaint.new(
      :customer => "",
      :info => "MyString",
      :complaintable => nil
    ))
  end

  it "renders new complaint form" do
    render

    assert_select "form[action=?][method=?]", complaints_path, "post" do

      assert_select "input[name=?]", "complaint[customer]"

      assert_select "input[name=?]", "complaint[info]"

      assert_select "input[name=?]", "complaint[complaintable_id]"
    end
  end
end
