class AddDescriptionToAstros < ActiveRecord::Migration[7.0]
  def change
    add_column :astros, :description, :text
  end
end
