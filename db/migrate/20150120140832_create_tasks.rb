class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.boolean :completed
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
