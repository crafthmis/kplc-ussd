module Equitable
  extend ActiveSupport::Concern
  included do
    has_many :equities, :as => :equitable
  end
end