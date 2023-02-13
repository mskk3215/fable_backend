class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string      :image,  null: false
      t.references  :user,   null: false, foreign_key: true
      t.references  :insect,              foreign_key: true
      t.references  :park,                foreign_key: true
      t.timestamps
    end
  end
end
