class AddImageToUser < ActiveRecord::Migration
  def change
    add_column :users, :image, :string, after: :hobby
  end
end
