class RemoveMeterIdFromMpesa < ActiveRecord::Migration[5.1]
  def change
    remove_column :mpesas, :meter_id, :integer
  end
end
