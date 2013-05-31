class AddDefaultValueToLimit < ActiveRecord::Migration
  def change
    change_column :users, :limit, :integer, :default => 6
  end
end
