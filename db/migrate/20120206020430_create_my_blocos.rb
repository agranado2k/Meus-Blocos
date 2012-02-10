class CreateMyBlocos < ActiveRecord::Migration
  def self.up
    create_table :my_blocos do |t|
      t.integer :user_id, :limit => 8
      t.integer :bloco_id

      t.timestamps
    end
  end

  def self.down
    drop_table :my_blocos
  end
end
