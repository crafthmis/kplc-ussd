require 'rails_helper'

RSpec.describe "confirmations/new", type: :view do
  before(:each) do
    assign(:confirmation, Confirmation.new(
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

  it "renders new confirmation form" do
    render

    assert_select "form[action=?][method=?]", confirmations_path, "post" do

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
