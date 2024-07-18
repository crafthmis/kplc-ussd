class AddLinkIdToBillable < ActiveRecord::Migration[5.2]
  def change
    add_column :billables, :link_id, :string
  end
end
