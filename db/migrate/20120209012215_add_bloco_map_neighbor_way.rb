class AddBlocoMapNeighborWay < ActiveRecord::Migration
  def change
    add_column :blocos, :map, :string
    add_column :blocos, :neighbor, :string
    add_column :blocos, :way, :string
  end
end
