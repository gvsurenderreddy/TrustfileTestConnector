class CreateConnectors < ActiveRecord::Migration
  def change
    create_table :connectors do |t|
      t.boolen :enabled
      t.integer :user_count
      t.timestamp :last_updated_at

      t.timestamps null: false
    end
  end
end
