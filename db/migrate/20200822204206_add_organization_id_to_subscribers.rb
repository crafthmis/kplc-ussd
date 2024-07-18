class AddOrganizationIdToSubscribers < ActiveRecord::Migration[5.2]
  def change
    add_reference :subscribers, :organization, foreign_key: true
  end
end
