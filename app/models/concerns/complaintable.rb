
module Complaintable
  extend ActiveSupport::Concern

  included do
    has_many :complaints, :as => :complaintable
  end
end