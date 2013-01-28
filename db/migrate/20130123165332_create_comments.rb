class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :post_id
      t.string :remember_post

      t.timestamps
    end
    add_index :comments, :content, unique: true
    add_index :comments, :user_id
    add_index :comments, :post_id
    add_index :comments, :created_at
    add_index :comments, :remember_post
  end
end
