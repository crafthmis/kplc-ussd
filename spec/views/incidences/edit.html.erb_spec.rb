require 'rails_helper'

RSpec.describe "incidences/edit", type: :view do
  before(:each) do
    @incidence = assign(:incidence, Incidence.create!(
      :kind => "MyString",
      :explanation => "MyString",
      :customer => nil
    ))
  end

  it "renders the edit incidence form" do
    render

    assert_select "form[action=?][method=?]", incidence_path(@incidence), "post" do

      assert_select "input[name=?]", "incidence[kind]"

      assert_select "input[name=?]", "incidence[explanation]"

      assert_select "input[name=?]", "incidence[customer_id]"
    end
  end
end
