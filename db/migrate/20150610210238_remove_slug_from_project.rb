class RemoveSlugFromProject < ActiveRecord::Migration
  def up
    remove_column :projects, :slug
  end

  def down
    add_column :projects, :slug, :string
  end
end
