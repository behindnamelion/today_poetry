class CreatePoets < ActiveRecord::Migration[5.2]
  def change
    create_table :poets do |t|
      t.string :name
      t.string :birthplace
      t.integer :birthyear
      t.text :description

      t.timestamps
    end
  end
end
