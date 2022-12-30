class RemoveMeanRadiusFromAstros < ActiveRecord::Migration[7.0]
  def change
    remove_column :astros, :mean_radius, :string
  end
end
