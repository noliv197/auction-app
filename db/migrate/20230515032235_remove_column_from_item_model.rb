class RemoveColumnFromItemModel < ActiveRecord::Migration[7.0]
  def change
    remove_column :item_models, :image, :string
  end
end
