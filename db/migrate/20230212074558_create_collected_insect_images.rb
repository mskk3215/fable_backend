# frozen_string_literal: true

class CreateCollectedInsectImages < ActiveRecord::Migration[7.0]
  def change
    create_table :collected_insect_images do |t|
      t.string :image, null: false
      
      t.references :collected_insect, null: false, foreign_key: true
      t.timestamps
    end
  end
end
