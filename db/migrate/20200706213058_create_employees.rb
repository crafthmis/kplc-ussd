class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :staff_number
      t.string :job_category
      t.string :region
      t.string :station
      t.string :job_title
      t.string :division
      t.string :section

      t.timestamps
    end
    add_index :employees, :staff_number, unique: true
  end
end
