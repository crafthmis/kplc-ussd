class AddOrganizationIdToMembership < ActiveRecord::Migration[5.2]
  def change
    add_reference :memberships, :organization, foreign_key: true
  end
end
