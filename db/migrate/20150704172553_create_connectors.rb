class CreateConnectors < ActiveRecord::Migration
  def change
    create_table :connectors do |t|
      t.string :name
      t.boolean :enabled, default: true
      t.integer :user_count, default: 0
      t.timestamp :last_updated_at
      t.timestamps :created_at
      t.integer :jobs_pending
      t.integer :jobs_duration_min
      t.integer :jobs_duration_max
      t.integer :jobs_duration_avg
      t.integer :hourly_synced_count
      t.integer :daily_synced_count
    end
  end
end
