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
      expect(bid.errors.full_messages[0]).to eq 'Usuário não pode ser administrador'
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
      expect(bid.errors.full_messages[0]).to eq 'Lance tem que ser maior ou igual ao lance mínimo do lote'

    end
    it 'para cliente mais de uma vez seguida' do
      admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
      client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')
      lot = Lot.create!(
        code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
        minimum_bid: 5, bids_difference: 10, status: 'approved', created_by: admin
      )
      first_bid = Bid.create!(user: client, lot: lot, value: 6)
      lot.update(last_bid: first_bid.value)
      second_bid = Bid.new(user: client, lot: lot, value: 20)

      expect(second_bid.valid?).to eq false
      expect(second_bid.errors.full_messages[0]).to eq 'Usuário tem que aguardar próximo lance'
    end
    it 'para lance menor que diferença entre lances' do
      admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
      first_client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')
      second_client = User.create!(email:'ana@email.com', password:'12345678', registration_number: '36767455075')
      lot = Lot.create!(
        code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
        minimum_bid: 5, bids_difference: 10, created_by: admin
      )
      first_bid = Bid.create!(user: first_client, lot: lot, value: 7)
      lot.update(last_bid: first_bid.value)
      second_bid = Bid.new(user: second_client, lot: lot, value: 9)

      expect(second_bid.valid?).to eq false
      expect(second_bid.errors.full_messages[0]).to eq 'Lance é menor que diferença entre lances'
    end
    it 'para lance menor que último lance' do
      admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
      first_client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')
      second_client = User.create!(email:'ana@email.com', password:'12345678', registration_number: '36767455075')
      lot = Lot.create!(
        code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
        minimum_bid: 5, bids_difference: 10, status: 'approved', created_by: admin
      )
      first_bid = Bid.create!(user: first_client, lot: lot, value: 25)
      lot.update(last_bid: first_bid.value)
      second_bid = Bid.new(user: second_client, lot: lot, value: 15)

      expect(second_bid.valid?).to eq false
    end
  end
end
