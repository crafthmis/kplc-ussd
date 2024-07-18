class AddMeterIdToMpesa < ActiveRecord::Migration[5.1]
  def change
    add_reference :mpesas, :meter, foreign_key: true
  end
end
