class ItemModel < ApplicationRecord
  before_validation :generate_code, on: :create
  
  has_one :lot_item
  has_one :lot, through: :lot_items
  has_one_attached :image
  enum status: {available: 0, unavailable: 5, sold:10}
  
  validates :name, :description, :weight, :length, 
  :width, :depth, :category, presence: true
  validates :weight,:length,:width,:depth, numericality: { greater_than: 0 }
  validates :code, uniqueness: true

  def dimension 
    "#{length}cm x #{width}cm x #{depth}cm"
  end
  def name_format
    "#{name} - #{code}"
  end

  private 


  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
