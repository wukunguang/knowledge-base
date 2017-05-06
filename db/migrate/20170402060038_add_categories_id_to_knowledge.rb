class AddCategoriesIdToKnowledge < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :categories_id, :integer
  end
end
