class AddVolumeToAstros < ActiveRecord::Migration[7.0]
  def change
    add_column :astros, :volume, :string
  end
end
