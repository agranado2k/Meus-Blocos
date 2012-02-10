class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.string :access_token
      t.integer :user_id, :limit => 8

      t.timestamps
    end
  end
end
