require 'rails_helper'

describe 'Cliente vê resultados de seus lances' do
    it 'mas não está autenticado' do
        visit results_lots_path

        expect(current_path).to eq new_user_session_path
    end
    it 'mas está com credencial errada' do
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')

        login_as admin
        visit results_lots_path

        expect(current_path).to eq root_path
        expect(page).to have_content 'Você não tem permissão para executar essa ação'
    end
    it 'e vence' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '36767455075')
        allow(Lot).to receive(:limit_date).with(Date.today).and_return(Date.today)
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, minimum_bid: 5, 
            bids_difference: 10, created_by: creator_admin
        )
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )
        lot_item = LotItem.create!(lot: first_lot, item_model: item)
        first_lot.approved!
        bid = Bid.create!(user: client, lot: first_lot, value: 6)

        login_as client
        visit root_path
        click_on 'Ver resultados'

        expect(page).to have_content 'Parabéns! O Lote ABC123456 é seu.'
    end
end