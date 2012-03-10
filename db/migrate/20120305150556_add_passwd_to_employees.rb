class AddPasswdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :passwd, :string
  end
end
