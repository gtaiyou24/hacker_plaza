class AddProjectPostIdToProjectPostComment < ActiveRecord::Migration
  def change
    add_column :project_post_comments, :project_post_id, :integer
  end
end
