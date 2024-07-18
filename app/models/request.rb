class Request < ApplicationRecord
 enum kind: { saf_ussd: 0, airtell_ussd: 1, equitell_ussd: 2 ,africas_ussd: 10}
 include Scopeable 

 belongs_to :customer 


end



