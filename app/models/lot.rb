class Lot < ApplicationRecord
    enum status: {pending: 0, approved: 1, closed: 2, canceled: 3}

    validates :code, :start_date, :limit_date, :minimum_bid, :bids_difference,
    presence: true
    validates :minimum_bid, numericality: { greater_than: 0 }
    validates :bids_difference, numericality: { greater_than: 1 }
    validates :start_date, comparison: { greater_than_or_equal_to: Date.today}
    validates :limit_date, comparison: { greater_than: :start_date }
    validates :code, uniqueness: true
    validate :verify_code

    def money_format
        "R$ #{minimum_bid},00"
    end
    private

    def verify_code
        code_validation_regex = /^[a-zA-Z]{3}[0-9]{6}$/
        if self.code.present? && Lot.find_by(code: self.code) == nil && !self.code.match?(code_validation_regex)
            self.errors.add(:code," o código deve ter 3 letras e 6 números")
        end
    end
end
