class AddFocusToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :focus, :string
  end
end
