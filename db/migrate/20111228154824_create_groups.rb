class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :is_feedbackgroup
      t.string :due
      t.string :share_with

      t.timestamps
    end
  end
end
