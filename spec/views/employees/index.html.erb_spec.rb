require 'rails_helper'

RSpec.describe "employees/index", type: :view do
  before(:each) do
    assign(:employees, [
      Employee.create!(
        :first_name => "First Name",
        :middle_name => "Middle Name",
        :last_name => "Last Name",
        :staff_number => 2,
        :job_category => "Job Category",
        :region => "Region",
        :station => "Station",
        :job_title => "Job Title",
        :division => "Division",
        :section => "Section"
      ),
      Employee.create!(
        :first_name => "First Name",
        :middle_name => "Middle Name",
        :last_name => "Last Name",
        :staff_number => 2,
        :job_category => "Job Category",
        :region => "Region",
        :station => "Station",
        :job_title => "Job Title",
        :division => "Division",
        :section => "Section"
      )
    ])
  end

  it "renders a list of employees" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Middle Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Job Category".to_s, :count => 2
    assert_select "tr>td", :text => "Region".to_s, :count => 2
    assert_select "tr>td", :text => "Station".to_s, :count => 2
    assert_select "tr>td", :text => "Job Title".to_s, :count => 2
    assert_select "tr>td", :text => "Division".to_s, :count => 2
    assert_select "tr>td", :text => "Section".to_s, :count => 2
  end
end
