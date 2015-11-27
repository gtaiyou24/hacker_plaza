class CreateProjectPosts < ActiveRecord::Migration
  def change
    create_table :project_posts do |t|
      t.integer :project_id, null: false
      t.string :title
      t.string :content
      t.string :image

      t.timestamps null: false
    end
  end
end
