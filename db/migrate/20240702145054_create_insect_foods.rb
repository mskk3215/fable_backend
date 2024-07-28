class CreateInsectFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :insect_foods do |t|
      t.references :insect, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
