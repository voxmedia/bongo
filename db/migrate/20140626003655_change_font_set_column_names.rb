class ChangeFontSetColumnNames < ActiveRecord::Migration
  def change
    rename_column :font_sets, :big_headline, :main_headline
    rename_column :font_sets, :small_headline, :secondary_headline
  end
end
