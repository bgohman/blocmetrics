class AddSlugToRegisteredApplications < ActiveRecord::Migration
  def change
    add_column :registered_applications, :slug, :string
    add_index :registered_applications, :slug
  end
end
