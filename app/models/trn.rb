class Trn < PrepaidVps
  self.table_name = "IPMP_MPESA.token_query"
  self.primary_key = "seqnum"

  def space_token
    token.to_s.gsub(/\D/, '').reverse.gsub(/.{4}/, '\0 ').reverse
  end

  

  
end
