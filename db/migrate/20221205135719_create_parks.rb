# frozen_string_literal: true

class CreateParks < ActiveRecord::Migration[7.0]
  def change
    create_table :parks do |t|
      t.string      :name, null: false
      t.string      :post_code
      t.string      :address
      t.float       :latitude
      t.float       :longitude
      t.references  :city, null: false, foreign_key: true
      t.references  :prefecture, null: false, foreign_key: true
      t.timestamps
    end
  end
end
