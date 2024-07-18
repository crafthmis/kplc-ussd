class RemoveOperationFromDemand < ActiveRecord::Migration[5.1]
  def change
    remove_column :demands, :operation, :string
  end
end
