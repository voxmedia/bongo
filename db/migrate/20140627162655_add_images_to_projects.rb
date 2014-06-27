class AddImagesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :feature_image_url, :string
    add_column :projects, :background_url, :string
    add_column :projects, :lede_image_url, :string
    add_column :projects, :three_up_first_url, :string
    add_column :projects, :three_up_last_url, :string
    add_column :projects, :primary_color, :string
    add_column :projects, :secondary_color, :string
  end
end
