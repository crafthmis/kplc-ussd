class AddOrganizationIdToAudience < ActiveRecord::Migration[5.2]
  def change
    add_reference :audiences, :organization, foreign_key: true
  end
end
