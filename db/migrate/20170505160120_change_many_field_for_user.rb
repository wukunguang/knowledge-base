class ChangeManyFieldForUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :u_id, :integer
  end
end
