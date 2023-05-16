class LotItem < ApplicationRecord
  belongs_to :lot
  belongs_to :item_model

  validates :item_model, uniqueness: true
end
