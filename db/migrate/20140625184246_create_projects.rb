class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :kit_id
      t.string :typekit_token

      t.timestamps
    end
  end
end
