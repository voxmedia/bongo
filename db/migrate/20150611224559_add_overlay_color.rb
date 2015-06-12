class AddOverlayColor < ActiveRecord::Migration
  def up
    add_column :projects, :overlay_color, :string
  end

  def down
    remove_column :projects, :overlay_color
  end
end
