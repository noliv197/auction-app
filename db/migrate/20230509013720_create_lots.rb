class CreateLots < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.string :code
      t.date :start_date
      t.date :limit_date
      t.integer :minimum_bid
      t.integer :bids_difference
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
