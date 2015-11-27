class CreateProjectPostComments < ActiveRecord::Migration
  def change
    create_table :project_post_comments do |t|
      t.integer :user_id
      t.string :comment

      t.timestamps null: false
    end
  end
end
