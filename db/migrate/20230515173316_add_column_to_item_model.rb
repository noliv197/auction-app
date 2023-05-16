class AddColumnToItemModel < ActiveRecord::Migration[7.0]
  def change
    add_column :item_models, :status, :integer, default:0
  end
end
