class CreateEmployeeTags < ActiveRecord::Migration
  def change
    create_table :employee_tags do |t|
      t.integer :employee_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
