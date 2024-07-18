class AddResolvedToComplaint < ActiveRecord::Migration[5.2]
  def change
    add_column :complaints, :resolved, :boolean, null: false, default: false
  end
end
