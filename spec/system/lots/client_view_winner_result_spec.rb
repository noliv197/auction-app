require 'rails_helper'

describe 'Cliente vê resultados de seus lances' do
    it 'mas não está autenticado' do
        visit result_lots_path

        expect(current_path).to eq new_user_session_path
    end
    it 'mas está com credencial errada' do
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')

        login_as admin
        visit result_lots_path

        expect(current_path).to eq root_path
        expect(page).to have_content 'Você não tem permissão para executar essa ação'
    end
    it 'e vence' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '36767455075')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 1.day.from_now,
            minimum_bid: 5,bids_difference: 10, created_by: creator_admin
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('ASE54D6D8D')
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )
        lot_item = LotItem.create!(lot: first_lot, item_model: item)
        first_lot.approved!
        bid = Bid.create!(user: client, lot: first_lot, value: 6)
        first_lot.closed!

        login_as client
        visit root_path
        click_on 'Ver resultados'

        expect(page).to have_content 'Parabéns! Você venceu o lote ABC123456.'
        expect(page).to have_link 'Mochila - ASE54D6D8D'
    end
    it 'e perde' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        first_client = User.create!(email:'ana@email.com', password:'12345678', registration_number: '41346779040')
        second_client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '36767455075')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 1.day.from_now,
            minimum_bid: 5,bids_difference: 10, created_by: creator_admin
        )
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )
        lot_item = LotItem.create!(lot: first_lot, item_model: item)
        first_lot.approved!
        first_bid = Bid.create!(user: first_client, lot: first_lot, value: 6)
        second_bid = Bid.create!(user: second_client, lot: first_lot, value: 30)
        first_lot.closed!

        login_as first_client
        visit root_path
        click_on 'Ver resultados'

        expect(page).to have_content 'Não foi dessa vez, o lote ABC123456 foi arrematado por outro usuário.'
    end
end