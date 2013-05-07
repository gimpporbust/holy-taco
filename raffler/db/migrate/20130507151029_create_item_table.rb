class CreateItemTable < ActiveRecord::Migration
  
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
    end
  end
  
end
