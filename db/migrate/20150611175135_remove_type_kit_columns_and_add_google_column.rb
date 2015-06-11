class RemoveTypeKitColumnsAndAddGoogleColumn < ActiveRecord::Migration
  def up
    remove_column :projects, :kit_id
    remove_column :projects, :typekit_token
    add_column :projects, :collection_url, :string
  end

  def down
    remove_column :projects, :collection_url
    add_column :projects, :kit_id, :string
    add_column :projects, :typekit_token, :string
  end
end
