class CreatePoems < ActiveRecord::Migration[5.2]
  def change
    create_table :poems do |t|
      t.string :title
      t.text :body
      t.integer :year
      t.text :description

      t.timestamps
    end
  end
end
