class AddUserAccountId < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :account_id, :string, null: false, default: 'None'
    add_index :users, :account_id, unique: true
  end
end
