class AddUserRefToAstros < ActiveRecord::Migration[7.0]
  def change
    add_reference :astros, :user, foreign_key: true
  end
end
