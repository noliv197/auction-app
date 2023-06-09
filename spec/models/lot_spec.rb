require 'rails_helper'

RSpec.describe Lot, type: :model do
  describe '#valid?' do
    context 'com campo vazio:'do 
      it 'código' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.new(
          code:'',start_date: 1.day.from_now,limit_date: 3.days.from_now,
          minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: user
        ) 
        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Código não pode ficar em branco"
      end
      it 'data inicio' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.new(
          code:'ABC123456',start_date: '',limit_date: 3.days.from_now,
          minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: user
        ) 
        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Data de Início não pode ficar em branco"
      end
      it 'data limite' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.new(
          code:'ABC123456',start_date: 1.day.from_now,limit_date: '',
          minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: user
        ) 
        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Data Limite não pode ficar em branco"
      end
      it 'valor minimo' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.new(
          code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
          minimum_bid: '', bids_difference: 10, status: 'pending', created_by: user
        ) 
        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Lance Mínimo não pode ficar em branco"
      end
      it 'diferença minima' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.new(
          code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
          minimum_bid: 5, bids_difference: '', status: 'pending', created_by: user
        ) 
        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Diferença Mínima Entre Lances não pode ficar em branco"
      end
    end
    context 'regra específica:' do
      it 'código deve ser único' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        Lot.create(
          code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
          minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: user
        ) 
        lot = Lot.new(
          code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
          minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: user
        ) 
        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Código já está em uso"
      end
      it 'código deve ter 3 letras e 6 caracteres' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.new(
          code:'123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
          minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: user
        ) 
        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Código deve ter 3 letras e 6 números"
      end
      it 'data inicio não pode estar no passado' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.new(
          code:'ABC123456',start_date: 3.days.ago,limit_date: 3.days.from_now,
          minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: user
        ) 

        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Data de Início deve ser maior ou igual a #{Date.today}"
      end
      it 'data limite não pode ser igual a data de inicio' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.new(
          code:'ABC123456',start_date: 1.day.from_now,limit_date: 1.day.from_now,
          minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: user
        ) 
        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Data Limite deve ser maior que #{1.day.from_now.to_date}"
      end
      it 'diferença minima deve ser maior que 1' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.new(
          code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
          minimum_bid: 5, bids_difference: 0, status: 'pending', created_by: user
        ) 
        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Diferença Mínima Entre Lances deve ser maior que 1"
      end
      it 'valor minimo deve ser maior que 0' do
        user = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.new(
          code:'ABC123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
          minimum_bid: -1, bids_difference: 10, status: 'pending', created_by: user
        ) 
        expect(lot.valid?).to eq false
        expect(lot.errors.full_messages[0]).to eq "Lance Mínimo deve ser maior que 0"
      end
    end
  end
end
