class CreateLotItems < ActiveRecord::Migration[7.0]
  def change
    create_table :lot_items do |t|
      t.references :lot, null: false, foreign_key: true
      t.references :item_model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
