class ChangeManyFieldForUser2 < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :login_account
    add_column :users, :last_login, :datetime
  end
end
