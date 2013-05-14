class MakeNameUniqueInUsers < ActiveRecord::Migration
  def up
  	add_index :users, :name, :unique => true
  end

  def down
  	add_index :users, :name
  end
end
