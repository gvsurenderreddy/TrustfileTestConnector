class CreateErrors < ActiveRecord::Migration
  def change
    create_table :errors do |t|
      t.string :error_type
      t.timestamp :error_timestamp
      t.string :message
      t.string :company_2_tf_token
      t.json :bad_orders
      t.string :friendly_message

      t.timestamps null: false
    end
    add_index(:errors, :company_2_tf_token)
  end
end
