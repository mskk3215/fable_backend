class CreateInsectTools < ActiveRecord::Migration[7.0]
  def change
    create_table :insect_tools do |t|
      t.references :insect, null: false, foreign_key: true
      t.references :tool, null: false, foreign_key: true

      t.timestamps
    end
  end
end
