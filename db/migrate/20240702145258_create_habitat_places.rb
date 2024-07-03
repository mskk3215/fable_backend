class CreateHabitatPlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :habitat_places do |t|
      t.string :name
      t.references :insect, null: false, foreign_key: true

      t.timestamps
    end
  end
end
