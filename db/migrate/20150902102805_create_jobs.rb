class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :media_type
      t.string :actions
      t.string :source_url
      t.string :destination_url
      t.string :notification_url
      t.string :original_media
      t.string :processed_media
      t.string :status

      t.timestamps null: false
    end
  end
end
