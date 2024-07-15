# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :collected_insect_image, null: false, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:user_id, :collected_insect_image_id], unique: true
  end
end
