class CreateTempimages < ActiveRecord::Migration
  def change
    create_table :tempimages do |t|
      t.string :image

      t.timestamps
    end
  end
end
