class AddOrganizationIdToSmsTemplate < ActiveRecord::Migration[5.2]
  def change
    add_reference :sms_templates, :organization, foreign_key: true
  end
end
