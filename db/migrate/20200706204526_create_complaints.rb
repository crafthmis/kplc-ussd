class CreateComplaints < ActiveRecord::Migration[5.1]
  def change
    create_table :complaints do |t|
      t.references :customer
      t.string :info
      t.references :complaintable, polymorphic: true

      t.timestamps
    end
  end
end
