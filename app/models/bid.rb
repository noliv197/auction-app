class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validates :value, presence: true
  validate :verify_credentials
  validate :check_client
  validate :check_value
  validate :check_bid_difference
  validate :check_lot_availability
  validate :check_lot_limit

  private
  def verify_credentials
    if self.user.present? && self.user.admin?
      self.errors.add(:user_id, "não pode ser administrador")
    end
  end
  def check_client
    if self.lot.last_bid.present? && self.user == self.lot.bids.last.user
      self.errors.add(:user_id,"tem que aguardar próximo lance")
    end
  end
  def check_value
    if self.value.present? && self.value < self.lot.minimum_bid
      self.errors.add(:value,"tem que ser maior ou igual ao lance mínimo do lote")
    end
  end
  def check_bid_difference
    if self.value.present? && self.value > self.lot.minimum_bid && self.lot.last_bid.present? && self.value < (self.lot.last_bid + self.lot.bids_difference)
      self.errors.add(:value,"é menor que diferença entre lances")
    end
  end
  def check_lot_availability
    if  self.lot.canceled? || self.lot.closed?
      self.errors.add(:lot_id,"não pode mais receber lances")
    end
  end
  def check_lot_limit
    if  self.lot.limit_date <= Date.today
      self.errors.add(:lot_id,"não pode mais receber lances")
    end
  end
end
