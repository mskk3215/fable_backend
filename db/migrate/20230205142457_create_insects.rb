class CreateInsects < ActiveRecord::Migration[7.0]
  def change
    create_table :insects do |t|
      t.string      :name, null: false
      t.string      :sex,  null: false
      t.timestamps
    end
  end
end
