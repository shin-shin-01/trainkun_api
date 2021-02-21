class CreateWishes < ActiveRecord::Migration[6.0]
  def change
    create_table :wishes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :star, null: false
      t.integer :status, null: false, default: 0, comment: 'default: wish'
      t.boolean :deleted, null: false, default: false

      t.timestamps
    end
  end
end
