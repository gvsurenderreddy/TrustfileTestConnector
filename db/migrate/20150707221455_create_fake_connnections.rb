class CreateFakeConnnections < ActiveRecord::Migration
  def change
    create_table :fake_connnections do |t|
      t.integer :datasource_id
      t.string :name
      t.string :state
      t.integer :sale_count
      t.integer :refund_count
      t.string :scenario

      t.timestamps null: false
    end
  end
end
