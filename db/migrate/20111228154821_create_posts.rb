class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :employee_id
      t.integer :group_id
      t.text :message
      t.string :photo

      t.timestamps
    end
  end
end
