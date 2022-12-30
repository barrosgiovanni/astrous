class RemoveVolumeFromAstros < ActiveRecord::Migration[7.0]
  def change
    remove_column :astros, :volume, :float
  end
end
