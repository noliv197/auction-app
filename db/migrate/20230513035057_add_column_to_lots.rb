class AddColumnToLots < ActiveRecord::Migration[7.0]
  def change
    add_column  :lots, :created_by_id, :integer
    add_column  :lots, :approved_by_id, :integer
    add_column  :lots, :last_bid, :integer
  end
end
