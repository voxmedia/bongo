class AddFontFamiliesToFontSets < ActiveRecord::Migration
  def change
    add_column :font_sets, :big_headline, :string
    add_column :font_sets, :small_headline, :string
    add_column :font_sets, :body, :string
    add_column :font_sets, :byline, :string
    add_column :font_sets, :pullquote, :string
    add_column :font_sets, :blockquote, :string
    add_column :font_sets, :big_number, :string
    add_column :font_sets, :big_number_label, :string
  end
end
