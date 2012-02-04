class CreateBlocos < ActiveRecord::Migration
  def change
    create_table :blocos do |t|
      t.string :name
      t.string :venue
      t.string :latitude
      t.string :longitude
      t.date :date
      t.string :hour
      t.string :photo_url

      t.timestamps
    end
  end
end
