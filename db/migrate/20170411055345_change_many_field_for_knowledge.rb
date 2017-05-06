class ChangeManyFieldForKnowledge < ActiveRecord::Migration[5.0]
  def change
    rename_column :knowledges, :users_id, :user_id
    rename_column :knowledges, :categories_id, :category_id

  end
end
