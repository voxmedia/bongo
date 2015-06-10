class DropAuthorizationAndUserTable < ActiveRecord::Migration
  def change
    drop_table :authorizations
    drop_table :users
  end
end
