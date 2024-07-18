class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :phone_number
      t.string :text
      t.string :session_id

      t.timestamps
    end
  end
end
