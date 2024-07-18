class CreateSmsTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :sms_templates do |t|
      t.string :name
      t.text :message

      t.timestamps
    end
  end
end
