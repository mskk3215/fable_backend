# frozen_string_literal: true

class CreateBiologicalFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :biological_families do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
