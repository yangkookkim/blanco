class ChangeGroupidOfChattergroup < ActiveRecord::Migration
  def up
    change_table :chattergroups do |c|
      c.rename :groupid, :chattergroupid
    end
  end

  def down
  end
end
