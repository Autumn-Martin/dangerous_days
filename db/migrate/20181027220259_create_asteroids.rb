class CreateAsteroids < ActiveRecord::Migration[5.1]
  def change
    create_table :asteroids do |t|
      t.string :name
      t.string :neo_reference_id
      t.boolean :is_potentially_hazardous_asteroid
      t.references :favorite, foreign_key: true

      t.timestamps
    end
  end
end
