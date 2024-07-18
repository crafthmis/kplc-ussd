require 'rails_helper'

RSpec.describe "employees/edit", type: :view do
  before(:each) do
    @employee = assign(:employee, Employee.create!(
      :first_name => "MyString",
      :middle_name => "MyString",
      :last_name => "MyString",
      :staff_number => 1,
      :job_category => "MyString",
      :region => "MyString",
      :station => "MyString",
      :job_title => "MyString",
      :division => "MyString",
      :section => "MyString"
    ))
  end

  it "renders the edit employee form" do
    render

    assert_select "form[action=?][method=?]", employee_path(@employee), "post" do

      assert_select "input[name=?]", "employee[first_name]"

      assert_select "input[name=?]", "employee[middle_name]"

      assert_select "input[name=?]", "employee[last_name]"

      assert_select "input[name=?]", "employee[staff_number]"

      assert_select "input[name=?]", "employee[job_category]"

      assert_select "input[name=?]", "employee[region]"

      assert_select "input[name=?]", "employee[station]"

      assert_select "input[name=?]", "employee[job_title]"

      assert_select "input[name=?]", "employee[division]"

      assert_select "input[name=?]", "employee[section]"
    end
  end
end
