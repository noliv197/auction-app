require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe '#valid?' do
  it 'para administradores' do
    admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
    lot = Lot.create!(
      code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
      minimum_bid: 5, bids_difference: 10, status: 'approved', created_by: admin
    )
    bid = Bid.new(user: admin, lot: lot, value: 5)

    expect(bid.valid?).to eq false
  end
    it 'para valor do lance vazio' do
      admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
      client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')
      lot = Lot.create!(
        code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
        minimum_bid: 5, bids_difference: 10, status: 'approved', created_by: admin
      )
      bid = Bid.new(user: client, lot: lot, value: '')

      expect(bid.valid?).to eq false
    end
    it 'para lance menor que lance mínimo do lote' do
      admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
      client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')
      lot = Lot.create!(
        code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
        minimum_bid: 5, bids_difference: 10, status: 'approved', created_by: admin
      )
      bid = Bid.new(user: client, lot: lot, value: 2)

      expect(bid.valid?).to eq false

    end
    it 'para lance menor que diferença entre lances' do
      admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
      client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')
      lot = Lot.create!(
        code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
        minimum_bid: 5, bids_difference: 10, status: 'approved', created_by: admin
      )
      bid = Bid.new(user: client, lot: lot, value: 7)

      expect(bid.valid?).to eq false
    end
    it 'para lance menor que último lance' do
      admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
      client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')
      lot = Lot.create!(
        code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
        minimum_bid: 5, bids_difference: 10, status: 'approved', created_by: admin
      )
      first_bid = Bid.create!(user: client, lot: lot, value: 25)
      second_bid = Bid.new(user: client, lot: lot, value: 15)

      expect(second_bid.valid?).to eq false
    end
  end
end
