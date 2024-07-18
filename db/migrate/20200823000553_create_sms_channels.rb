class CreateSmsChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :sms_channels do |t|
      t.string :type
      t.string :shortcode
      t.string :alphanumeric
      t.string :keyword
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
