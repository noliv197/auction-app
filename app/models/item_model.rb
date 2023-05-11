class ItemModel < ApplicationRecord
  before_validation :generate_code, on: :create
  
  validates :name, :description, :image, :weight, :length, 
  :width, :depth, :category, presence: true
  validates :weight,:length,:width,:depth, numericality: { greater_than: 0 }
  validates :code, uniqueness: true

  def dimension 
    "#{length}cm x #{width}cm x #{depth}cm"
  end

  private 

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
