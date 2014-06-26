class CreateFontSets < ActiveRecord::Migration
  def change
    create_table :font_sets do |t|
      t.text :sass
      t.belongs_to :project, index: true

      t.timestamps
    end
  end
end
