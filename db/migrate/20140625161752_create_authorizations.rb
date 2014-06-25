class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer  "user_id",       null: false
      t.string   "provider",      null: false
      t.string   "uid",           null: false
      t.string   "link"
      t.string   "name"
      t.string   "nickname"
      t.string   "image"
      t.string   "token"
      t.string   "secret"
      t.boolean  "expires"
      t.integer  "expires_at"
      t.string   "refresh_token"
      t.timestamps
    end
  end
end