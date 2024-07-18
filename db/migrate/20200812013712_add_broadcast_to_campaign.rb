class AddBroadcastToCampaign < ActiveRecord::Migration[5.1]
  def change
    add_column :campaigns, :broadcast_contacts, :string
    add_column :campaigns, :failed_contacts, :string
  end
end
