class CreateUserLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :user_locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :city

      t.timestamps
    end
  end
end
