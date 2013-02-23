class AddUrlnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :urlname, :string
  end
end
