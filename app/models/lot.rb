class Lot < ApplicationRecord
    belongs_to :created_by, :class_name => "User"
    belongs_to :approved_by, :class_name => "User" , required: false

    has_many :bids
    has_many :lot_items 
    has_many :item_models, through: :lot_items
    enum status: {pending: 0, approved: 1, closed: 2, canceled: 3}

    validates :code, :start_date, :limit_date, :minimum_bid, :bids_difference,
    presence: true
    validates :minimum_bid, numericality: { greater_than: 0 }
    validates :bids_difference, numericality: { greater_than: 1 }
    validates :start_date, comparison: { greater_than_or_equal_to: Time.current.to_date}
    validates :limit_date, comparison: { greater_than: :start_date }
    validates :code, uniqueness: true
    validate :verify_code

    def money_format(number)
        convertion = sprintf('%.2f', number).sub('.',',')
        "R$ #{convertion}"
    end
    
    private

    def verify_code
        code_validation_regex = /^[a-zA-Z]{3}[0-9]{6}$/
        if self.code.present? && Lot.find_by(code: self.code) == nil && !self.code.match?(code_validation_regex)
            self.errors.add(:code,"deve ter 3 letras e 6 números")
        end
    end
end
