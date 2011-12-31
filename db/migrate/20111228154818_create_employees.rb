class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :profile_selfphoto
      t.string :profile_tel
      t.string :profile_email
      t.string :profile_department
      t.string :profile_hobby
      t.string :profile_askme
      t.string :profile_language
      t.string :profile_nationality
      t.string :profile_hometown
      t.string :profile_focus
      t.string :profile_workplace

      t.timestamps
    end
  end
end
