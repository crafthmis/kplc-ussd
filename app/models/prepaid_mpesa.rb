 class PrepaidMpesa < ActiveRecord::Base
   self.abstract_class = true
   #establish_connection PREPAID_MPESA_PR_DB
   establish_connection  PREPAID_MPESA_DR_DB

       # Prevent creation of new records and modification to existing records
    def readonly?
        return true
    end

    # Prevent objects from being destroyed
    def before_destroy
        raise ActiveRecord::ReadOnlyRecord
    end

end
