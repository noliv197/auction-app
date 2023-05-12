require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'campo vazio: ' do
      it 'senha' do
        user = User.new(email:'natalia@email.com', password:'', registration_number: '14538220620')
  
        expect(user.valid?).to eq false
      end
      it 'email' do
        user = User.new(email:'', password:'12345678', registration_number: '14538220620')
  
        expect(user.valid?).to eq false
      end
      it 'cpf' do
        user = User.new(email:'natalia@email.com', password:'12345678', registration_number: '')
  
        expect(user.valid?).to eq false
      end
    end
    context 'valor único: ' do
      it 'email' do
        User.create!(email:'natalia@email.com', password:'12345678', registration_number: '36767455075')
        user = User.new(email:'natalia@email.com', password:'12345678', registration_number: '14538220620')
  
        expect(user.valid?).to eq false
      end
      it 'cpf' do
        User.create!(email:'natalia@email.com', password:'12345678', registration_number: '36767455075')
        user = User.new(email:'ana@email.com', password:'12345678', registration_number: '36767455075')
  
        expect(user.valid?).to eq false
      end
    end
    context 'regra específica: ' do
      it 'senha com no mínimo 6 caracteres' do
        user = User.new(email:'natalia@email.com', password:'1234', registration_number: '14538220620')
  
        expect(user.valid?).to eq false
      end
      it 'cpf tem que ter 11 caracteres' do
        user = User.new(email:'natalia@email.com', password:'12345678', registration_number: '145382')
  
        expect(user.valid?).to eq false
      end
      it 'cpf válido' do
        user = User.new(email:'natalia@email.com', password:'12345678', registration_number: '12345678912')
  
        expect(user.valid?).to eq false
      end
    end
  end
  describe 'checagem de credencial' do 
    it 'admin' do
      user = User.new(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')

      expect(user.admin?).to eq false
    end
    it 'client' do
      user = User.new(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')

      expect(user.client?).to eq false
    end
  end
end
