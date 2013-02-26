class AddDefaultValuesToFoodAttributes < ActiveRecord::Migration
  def up
  	change_column_default(:foods, :carb, 0)
  	change_column_default(:foods, :fat, 0)
  	change_column_default(:foods, :gi, 0)
  	change_column_default(:foods, :kkal, 0)
  	change_column_default(:foods, :protein, 0)
  	change_column_default(:foods, :water, 0)
  end

  def down
  	change_column_default(:foods, :carb, nil)
  	change_column_default(:foods, :fat, nil)
  	change_column_default(:foods, :gi, nil)
  	change_column_default(:foods, :kkal, nil)
  	change_column_default(:foods, :protein, nil)
  	change_column_default(:foods, :water, nil)  	
  end
end
