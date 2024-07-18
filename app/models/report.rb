class Report < ActiveRecord::Base
   self.abstract_class = true
   establish_connection INCMS_REPORT_PR_DB

       # Prevent creation of new records and modification to existing records
    def readonly?
      return true
    end

    # Prevent objects from being destroyed
    def before_destroy
      raise ActiveRecord::ReadOnlyRecord
    end





    def self.sales 

    end
    
end
