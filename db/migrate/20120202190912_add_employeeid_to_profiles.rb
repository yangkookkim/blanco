class AddEmployeeidToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :employee_id, :integer
  end
end
