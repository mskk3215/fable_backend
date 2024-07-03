# frozen_string_literal: true

class CreateInsects < ActiveRecord::Migration[7.0]
  def change
    create_table :insects do |t|
      t.string      :name, null: false
      t.string      :sex,  null: false
      t.references  :biological_family, null: false, foreign_key: true
      t.references  :habitat_place, null: false, foreign_key: true
      t.timestamps
    end
  end
end
