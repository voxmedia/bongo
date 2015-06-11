class RemoveSlugFromFontSet < ActiveRecord::Migration
  def up
    remove_column :font_sets, :slug
  end

  def down
    add_column :font_sets, :slug, :string
  end
end
