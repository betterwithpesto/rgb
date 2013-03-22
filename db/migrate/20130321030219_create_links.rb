class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :user
      t.string :name
      t.string :url

      t.timestamps
    end
    add_index :links, :user_id
  end
end
