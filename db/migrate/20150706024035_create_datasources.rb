class CreateDatasources < ActiveRecord::Migration
  def change
    create_table :datasources do |t|
      t.boolean :enabled, :default => false
      t.boolean :authorized, :default => false
      t.date :start_date, :required => true
      t.string :company_2_tf_token :null => false
      t.timestamp :status_changed_at
      t.timestamp :last_sync_at
      t.timestamp :next_sync_at
      t.string :status_message

      t.timestamps null: false
    end
    add_index(:datasources, :company_2_tf_token)
  end
end
