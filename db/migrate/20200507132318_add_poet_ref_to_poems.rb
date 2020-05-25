class AddPoetRefToPoems < ActiveRecord::Migration[5.2]
  def change
    add_reference :poems, :poet, foreign_key: true
  end
end
