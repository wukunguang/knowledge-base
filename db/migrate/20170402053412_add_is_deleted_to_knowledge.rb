class AddIsDeletedToKnowledge < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :is_deleted, :boolean
  end
end
