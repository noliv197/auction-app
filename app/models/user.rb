class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_validation :set_credentials, on: :create
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum credentials: {admin: 0, client: 1}
  
  validates :registration_number, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, length: {is: 11}
  validate :validate_registration_number
  
  private

  def set_credentials
    mail = self.email.split('@')[1]
    mail === 'leilaodogalpao.com.br' ? self.credentials = 'admin' : self.credentials = 'client'
  end
  def validate_registration_number
    if (self.registration_number.present? && 
        User.find_by(registration_number: self.registration_number) == nil && 
        self.registration_number.length === 11 &&
        !is_registration_number_valid(self.registration_number)
      )
        self.errors.add(:registration_number,"inválido")
    end
  end
  def is_registration_number_valid(reg_num)
    if reg_num.scan(reg_num[0]).length() == 11
      return false
    elsif verifying_digit(10,reg_num) != reg_num[9].to_i
      return false
    elsif verifying_digit(11,reg_num) != reg_num[10].to_i
      return false
    end
    true
  end
  def verifying_digit(range,reg_num)
    sum = 0
    for n in 0..(range-2) do
      sum += range * reg_num[n].to_i
      range -= 1
    end
    rest = (sum * 10) % 11
    if rest >= 10
      rest = 0
    end
    rest
  end
end
