class AddKindToRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :kind, :integer
    add_index :requests, :kind
  end
end
