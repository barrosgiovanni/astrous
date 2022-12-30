class AddMeanRadiusToAstros < ActiveRecord::Migration[7.0]
  def change
    add_column :astros, :mean_radius, :float
  end
end
