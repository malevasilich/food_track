class AddKkalAndWaterToFood < ActiveRecord::Migration
  def change
    add_column :foods, :kkal, :float
    add_column :foods, :water, :float
  end
end
