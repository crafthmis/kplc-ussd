json.extract! confirmation, :id, :seqnum, :create_date, :billrefnumber, :transamount, :transid, :transtype, :kptransid, :mobilenumber, :transtime, :invoicenumber, :messages, :status, :lastamount, :messageid, :method, :userid, :created_at, :updated_at
json.url confirmation_url(confirmation, format: :json)
