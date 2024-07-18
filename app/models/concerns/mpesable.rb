module Mpesable
  extend ActiveSupport::Concern
  included do
    has_many :mpesas, :as => :mpesable
  end
end