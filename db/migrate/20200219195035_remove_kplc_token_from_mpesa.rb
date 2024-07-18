class RemoveKplcTokenFromMpesa < ActiveRecord::Migration[5.1]
  def change
    remove_column :mpesas, :kplc_token, :string
  end
end
