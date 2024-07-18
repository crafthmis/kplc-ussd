class AddMessageableToMessage < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :messageable, polymorphic: true
  end
end
