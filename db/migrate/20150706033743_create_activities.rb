class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :datasource_id
      t.timestamp :activity_timestamp
      t.string :action

      t.timestamps null: false
    end
  end
end
