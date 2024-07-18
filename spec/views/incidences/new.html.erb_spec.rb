require 'rails_helper'

RSpec.describe "incidences/new", type: :view do
  before(:each) do
    assign(:incidence, Incidence.new(
      :kind => "MyString",
      :explanation => "MyString",
      :customer => nil
    ))
  end

  it "renders new incidence form" do
    render

    assert_select "form[action=?][method=?]", incidences_path, "post" do

      assert_select "input[name=?]", "incidence[kind]"

      assert_select "input[name=?]", "incidence[explanation]"

      assert_select "input[name=?]", "incidence[customer_id]"
    end
  end
end
