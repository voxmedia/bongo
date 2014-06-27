class AddLogoToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :logo_url, :string
  end
end
