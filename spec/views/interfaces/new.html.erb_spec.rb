require 'rails_helper'

RSpec.describe "interfaces/new", type: :view do
  before(:each) do
    assign(:interface, Interface.new(
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new interface form" do
    render

    assert_select "form[action=?][method=?]", interfaces_path, "post" do

      assert_select "input[name=?]", "interface[name]"

      assert_select "input[name=?]", "interface[description]"
    end
  end
end
