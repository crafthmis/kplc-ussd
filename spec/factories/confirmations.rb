FactoryBot.define do
  factory :confirmation do
    seqnum { 1 }
    create_date { "2020-06-10" }
    billrefnumber { "MyString" }
    transamount { "MyString" }
    transid { "MyString" }
    transtype { "MyString" }
    kptransid { "MyString" }
    mobilenumber { "MyString" }
    transtime { "2020-06-10" }
    invoicenumber { "MyString" }
    messages { "MyString" }
    status { "MyString" }
    lastamount { 1 }
    messageid { "MyString" }
    #method { "9.99" }
    userid { "MyString" }
  end
end
