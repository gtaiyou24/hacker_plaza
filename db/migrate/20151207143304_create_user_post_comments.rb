class CreateUserPostComments < ActiveRecord::Migration
  def change
    create_table :user_post_comments do |t|
      t.integer :user_id
      t.integer :user_post_id
      t.text :comment

      t.timestamps null: false
    end
  end
end
