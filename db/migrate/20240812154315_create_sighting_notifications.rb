class CreateSightingNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :sighting_notifications do |t|
      t.boolean :is_read, default: false, null: false
      t.references :user, null: false, foreign_key: true
      t.references :collected_insect, null: false, foreign_key: true

      t.timestamps
    end
  end
end
