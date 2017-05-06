class ChangeManyFieldForCategories < ActiveRecord::Migration[5.0]
  def change
    drop_table :photos
    remove_column :knowledges, :photo_id, :integer
    add_column :categories, :user_id, :integer
  end
end
