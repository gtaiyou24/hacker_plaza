class CreateUserPosts < ActiveRecord::Migration
  def change
    create_table :user_posts do |t|
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
    add_index :user_posts, [:user_id, :created_at]
  end
end
