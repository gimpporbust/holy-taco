class CreateOrderTable < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string      :patron
      t.references  :item
      t.decimal     :total
    end
  end
end
