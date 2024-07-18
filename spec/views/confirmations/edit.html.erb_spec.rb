require 'rails_helper'

RSpec.describe "confirmations/edit", type: :view do
  before(:each) do
    @confirmation = assign(:confirmation, Confirmation.create!(
      :seqnum => 1,
      :billrefnumber => "MyString",
      :transamount => "MyString",
      :transid => "MyString",
      :transtype => "MyString",
      :kptransid => "MyString",
      :mobilenumber => "MyString",
      :invoicenumber => "MyString",
      :messages => "MyString",
      :status => "MyString",
      :lastamount => 1,
      :messageid => "MyString",
      :method => "9.99",
      :userid => "MyString"
    ))
  end

  it "renders the edit confirmation form" do
    render

    assert_select "form[action=?][method=?]", confirmation_path(@confirmation), "post" do

      assert_select "input[name=?]", "confirmation[seqnum]"

      assert_select "input[name=?]", "confirmation[billrefnumber]"

      assert_select "input[name=?]", "confirmation[transamount]"

      assert_select "input[name=?]", "confirmation[transid]"

      assert_select "input[name=?]", "confirmation[transtype]"

      assert_select "input[name=?]", "confirmation[kptransid]"

      assert_select "input[name=?]", "confirmation[mobilenumber]"

      assert_select "input[name=?]", "confirmation[invoicenumber]"

      assert_select "input[name=?]", "confirmation[messages]"

      assert_select "input[name=?]", "confirmation[status]"

      assert_select "input[name=?]", "confirmation[lastamount]"

      assert_select "input[name=?]", "confirmation[messageid]"

      assert_select "input[name=?]", "confirmation[method]"

      assert_select "input[name=?]", "confirmation[userid]"
    end
  end
end
