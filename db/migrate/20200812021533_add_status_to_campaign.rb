class AddStatusToCampaign < ActiveRecord::Migration[5.1]
  def change
    add_column :campaigns, :status, :string
  end
end
