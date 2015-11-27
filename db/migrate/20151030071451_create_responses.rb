class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :thread_table_id
      t.integer :user_id
      t.text :content

      t.timestamps null: false
    end
  end
end
