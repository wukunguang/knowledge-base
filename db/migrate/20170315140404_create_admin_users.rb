class CreateAdminUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :username
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false
      t.integer :login_account, default: 1
    end
  end

end
