class AddNumberIdToMeter < ActiveRecord::Migration[5.1]
  def change
    add_index :meters, :number
  end
end
