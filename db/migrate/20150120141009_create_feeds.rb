class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.text :description
      t.string :file
      t.string :type
      t.integer :user_id
      t.integer :task_id

      t.timestamps
    end
  end
end
