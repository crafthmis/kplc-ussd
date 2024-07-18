class Interface < ApplicationRecord
  has_many :organization_interfaces, :dependent => :destroy
  has_many :organizations , through: :organization_interfaces

end
