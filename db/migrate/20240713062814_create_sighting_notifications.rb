class CreateSightingNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :sighting_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :insect, null: false, foreign_key: true

      t.timestamps
    end
  end
end
