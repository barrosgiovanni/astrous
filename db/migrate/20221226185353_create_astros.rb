class CreateAstros < ActiveRecord::Migration[7.0]
  def change
    create_table :astros do |t|
      t.string :name
      t.string :body_type
      t.string :around_planet
      t.string :mass_value
      t.integer :average_temperature
      t.float :volume
      t.float :density
      t.float :gravity
      t.string :mean_radius
      t.string :discovered_by
      t.date :discovered_date
      t.integer :price
      t.string :image_url

      t.timestamps
    end
  end
end
