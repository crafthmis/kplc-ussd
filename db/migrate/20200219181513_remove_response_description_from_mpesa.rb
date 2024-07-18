class RemoveResponseDescriptionFromMpesa < ActiveRecord::Migration[5.1]
  def change
    remove_column :mpesas, :response_description, :string
    remove_column :mpesas, :response_code, :string
  end
end
