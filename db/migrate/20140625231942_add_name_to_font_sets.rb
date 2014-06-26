class AddNameToFontSets < ActiveRecord::Migration
  def change
    add_column :font_sets, :name, :string
  end
end
