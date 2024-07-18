class AddStateToComplaint < ActiveRecord::Migration[5.2]
  def change
    add_column :complaints, :state, :string
  end
end
