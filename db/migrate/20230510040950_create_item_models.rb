class CreateItemModels < ActiveRecord::Migration[7.0]
  def change
    create_table :item_models do |t|
      t.string :name
      t.string :description
      t.string :image
      t.integer :weight
      t.integer :length
      t.integer :width
      t.integer :depth
      t.string :category
      t.string :code

      t.timestamps
    end
  end
end
