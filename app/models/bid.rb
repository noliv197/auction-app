class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validates :value, presence: true
  validate :check_value
  validate :verify_credentials

  private
  def verify_credentials
    if self.user.present? && self.user.admin?
      self.errors.add(:user_id, "não pode ser administrador")
    end
  end
  def check_value
    if self.value.present? && self.value < self.lot.minimum_bid
      self.errors.add(:value," valor tem que ser maior ou igual ao lance mínimo do lote")
    end
  end
  
  def check_bid_difference
    # if self.lot.last_bid.present? && self.last_bid
    #   self.errors.add(:value," é menor que diferença entre lances")
    # end
    #checar ultimo lance
    #if bids.empty? value >= minimum_bid
    #else get last bid and compare bid_difference
  end
end
