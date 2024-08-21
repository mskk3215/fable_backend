class CreateSightingNotificationSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :sighting_notification_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :insect, null: false, foreign_key: true

      t.timestamps
    end
       add_index :sighting_notification_settings, %i[user_id insect_id], unique: true
  end
end
