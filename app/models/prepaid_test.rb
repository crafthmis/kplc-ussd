class PrepaidTest < ActiveRecord::Base
   self.abstract_class = true
   #establish_connection PREPAID_TEST_DB
   establish_connection PREPAID_VPS_DR_DB

       # Prevent creation of new records and modification to existing records
    def readonly?
      return true
    end

    # Prevent objects from being destroyed
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end

end
