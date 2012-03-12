class CreateChatterprofiles < ActiveRecord::Migration
  def change
    create_table :chatterprofiles do |t|
      t.string :chatter_id
      t.integer :profile_id

      t.timestamps
    end
  end
end
