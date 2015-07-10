class AddRedirectToDatasources < ActiveRecord::Migration
  def change
    add_column :datasources, :redirect, :string
  end
end
