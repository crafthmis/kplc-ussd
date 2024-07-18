require 'rails_helper'

RSpec.describe "employees/show", type: :view do
  before(:each) do
    @employee = assign(:employee, Employee.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Middle Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Job Category/)
    expect(rendered).to match(/Region/)
    expect(rendered).to match(/Station/)
    expect(rendered).to match(/Job Title/)
    expect(rendered).to match(/Division/)
    expect(rendered).to match(/Section/)
  end
end
