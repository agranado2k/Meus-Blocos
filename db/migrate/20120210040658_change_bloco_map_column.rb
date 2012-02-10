class ChangeBlocoMapColumn < ActiveRecord::Migration
  def change
    change_column :blocos, :map, :text
  end
end
