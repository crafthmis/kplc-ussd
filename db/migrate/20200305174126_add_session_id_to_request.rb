class AddSessionIdToRequest < ActiveRecord::Migration[5.1]
  def change
    add_index :requests, :session_id
  end
end
