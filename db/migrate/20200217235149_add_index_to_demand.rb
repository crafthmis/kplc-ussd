class AddIndexToDemand < ActiveRecord::Migration[5.1]
  def change
    add_index :demands, :link_id
  end
end
