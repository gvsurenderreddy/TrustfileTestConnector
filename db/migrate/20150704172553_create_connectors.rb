class CreateConnectors < ActiveRecord::Migration
  def change
    create_table :connectors do |t|
      t.boolean :enabled, default: true
      t.integer :user_count, default: 0
      t.timestamp :last_updated_at
      t.timestamps :created_at
    end
  end
end
