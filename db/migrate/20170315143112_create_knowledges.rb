class CreateKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :knowledges do |t|

      t.timestamps
      t.string :title
      t.text :content
      t.string :author
      t.integer :users_id
    end
  end
end
