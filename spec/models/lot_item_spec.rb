require 'rails_helper'

RSpec.describe LotItem, type: :model do
    describe '#valid?' do
        it 'não pode estar associado a mais de um lote' do
            admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
            first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: admin
            ) 
            second_lot = Lot.create!(
                code:'DEF123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
                minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: admin
            )  
            item = ItemModel.create!(
                name:'Mochila',description:"Cor preta; À prova d'água",
                weight: 10, length: 20,width:5,depth:30,category:'bolsas'
            )

            first_lot_item = LotItem.create!(lot: first_lot, item_model: item)
            second_lot_item = LotItem.new(lot: second_lot, item_model: item)

            expect(second_lot_item.valid?).to eq false
        end
    end
end
