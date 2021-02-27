class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      # TODO: 友達の仕組みをアップデートする
      t.references :user, null: false, foreign_key: { to_table: 'users' }
      t.references :friend_user, null: false, foreign_key: { to_table: 'users' }
      t.boolean :deleted, null: false, default: false

      t.timestamps
    end

    add_index :friends, [:user_id, :friend_user_id], unique: true
  end
end
