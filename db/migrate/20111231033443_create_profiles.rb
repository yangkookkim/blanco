class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :selfphoto
      t.string :imagephoto
      t.string :tel
      t.string :email
      t.string :department
      t.string :hobby
      t.string :askme
      t.string :language
      t.string :nationality
      t.string :hometown
      t.string :foucs
      t.string :workplace

      t.timestamps
    end
  end
end
