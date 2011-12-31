class RemoveProfileFromEmployee < ActiveRecord::Migration
  def up
    remove_column :employees, :profile_selfphoto
    remove_column :employees, :profile_imagephoto
    remove_column :employees, :profile_tel
    remove_column :employees, :profile_email
    remove_column :employees, :profile_department
    remove_column :employees, :profile_hobby
    remove_column :employees, :profile_askme
    remove_column :employees, :profile_language
    remove_column :employees, :profile_nationality
    remove_column :employees, :profile_hometown
    remove_column :employees, :profile_foucs
    remove_column :employees, :profile_workplace
  end

  def down
    add_column :employees, :profile_workplace, :string
    add_column :employees, :profile_foucs, :string
    add_column :employees, :profile_hometown, :string
    add_column :employees, :profile_nationality, :string
    add_column :employees, :profile_language, :string
    add_column :employees, :profile_askme, :string
    add_column :employees, :profile_hobby, :string
    add_column :employees, :profile_department, :string
    add_column :employees, :profile_email, :string
    add_column :employees, :profile_tel, :string
    add_column :employees, :profile_imagephoto, :string
    add_column :employees, :profile_selfphoto, :string
  end
end
