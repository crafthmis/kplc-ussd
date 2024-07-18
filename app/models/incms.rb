class Incms < ActiveRecord::Base
  self.abstract_class = true
  #establish_connection INCMS_PR_DB
  establish_connection INCMS_DR_DB




end




