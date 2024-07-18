require 'rails_helper'

RSpec.describe "incidences/index", type: :view do
  before(:each) do
    assign(:incidences, [
      Incidence.create!(
        :kind => "Kind",
        :explanation => "Explanation",
        :customer => nil
      ),
      Incidence.create!(
        :kind => "Kind",
        :explanation => "Explanation",
        :customer => nil
      )
    ])
  end

  it "renders a list of incidences" do
    render
    assert_select "tr>td", :text => "Kind".to_s, :count => 2
    assert_select "tr>td", :text => "Explanation".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
