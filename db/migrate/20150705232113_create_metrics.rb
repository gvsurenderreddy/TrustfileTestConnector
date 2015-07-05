class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.integer :jobs_pending
      t.integer :jobs_duration_min
      t.integer :jobs_duration_max
      t.integer :jobs_duration_avg
      t.integer :hourly_synced_count
      t.integer :daily_synced_count

      t.timestamps null: false
    end
  end
end
