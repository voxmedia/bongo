class AddSlugToFontSets < ActiveRecord::Migration
  def change
    add_column :font_sets, :slug, :string
  end
end
