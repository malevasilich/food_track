class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.float :protein
      t.float :fat
      t.float :carb
      t.float :kkal
      t.float :water
      t.integer :gi

      t.timestamps
    end
  end
end
