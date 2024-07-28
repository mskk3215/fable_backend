class CreateCollectedInsects < ActiveRecord::Migration[7.0]
  def change
    create_table :collected_insects do |t|
      t.string      :sex
      t.datetime :taken_date_time

      t.integer :likes_count, default: 0, null: false
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.references :insect,  foreign_key: true
      t.references :park,                foreign_key: true
      t.references :city,                foreign_key: true
      t.timestamps
    end
  end
end
