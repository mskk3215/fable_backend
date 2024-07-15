# frozen_string_literal: true

class CreateCollectedInsectImages < ActiveRecord::Migration[7.0]
  def change
    create_table :collected_insect_images do |t|
      t.string :image, null: false
      t.datetime :taken_at
      t.integer :likes_count, default: 0, null: false
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.references :insect,              foreign_key: true
      t.references :park,                foreign_key: true
      t.references :city,                foreign_key: true
      t.timestamps
    end
  end
end
