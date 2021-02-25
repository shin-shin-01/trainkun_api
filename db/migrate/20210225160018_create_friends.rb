class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      # TODO: 友達の仕組みをアップデートする
      t.references :user, null: false, foreign_key: true
      t.references :friend, null: false, foreign_key: true
      t.boolean :deleted, null: false, default: false

      t.timestamps
    end
  end
end
