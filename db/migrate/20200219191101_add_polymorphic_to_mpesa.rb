class AddPolymorphicToMpesa < ActiveRecord::Migration[5.1]
  def change
    add_reference :mpesas, :mpesable, polymorphic: true
  end
end
