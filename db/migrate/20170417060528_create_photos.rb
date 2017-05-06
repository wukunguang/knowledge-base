class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :image
      t.timestamps
    end
    add_column :knowledges, :photo_id, :integer
  end
end
