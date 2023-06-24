# frozen_string_literal: true

class CreateInsectParks < ActiveRecord::Migration[7.0]
  def change
    create_table :insect_parks do |t|
      t.references :insect, null: false, foreign_key: true
      t.references :park, null: false, foreign_key: true
      t.timestamps
    end
  end
end
