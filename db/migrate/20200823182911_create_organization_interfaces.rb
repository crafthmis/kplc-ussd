class CreateOrganizationInterfaces < ActiveRecord::Migration[5.2]
  def change
    create_table :organization_interfaces do |t|
      t.references :interface, foreign_key: true
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
