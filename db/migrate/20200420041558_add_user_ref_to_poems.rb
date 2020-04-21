class AddUserRefToPoems < ActiveRecord::Migration[5.2]
  def change
    add_reference :poems, :user, foreign_key: true
  end
end
