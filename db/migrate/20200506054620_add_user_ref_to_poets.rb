class AddUserRefToPoets < ActiveRecord::Migration[5.2]
  def change
    add_reference :poets, :user, foreign_key: true
  end
end
