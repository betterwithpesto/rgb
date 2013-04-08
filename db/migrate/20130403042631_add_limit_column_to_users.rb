class AddLimitColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :limit, :int
  end
end
