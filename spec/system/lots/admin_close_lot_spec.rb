require 'rails_helper'

describe 'Administrador encerra lotes' do
    it 'mas não está autenticado' do
        visit to_close_lots_path

        expect(current_path).to eq new_user_session_path
    end
    it 'mas está com credencial errada' do
        client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')

        login_as client
        visit to_close_lots_path

        expect(current_path).to eq root_path
        expect(page).to have_content 'Você não tem permissão para executar essa ação'
    end
    it 'com sucesso' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '36767455075')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 1.day.from_now,
            minimum_bid: 5, bids_difference: 10, created_by: creator_admin
        )
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )
        lot_item = LotItem.create!(lot: first_lot, item_model: item)
        first_lot.approved!
        bid = Bid.create!(user: client, lot: first_lot, value: 6)
        first_lot.update(last_bid: bid.value)
        travel 2.days

        login_as creator_admin
        visit root_path
        click_on 'Lotes expirados'
        within 'div#ABC123456' do
            click_on 'Encerrar'
        end

        expect(page).to have_content 'Lote Encerrado com Sucesso'
    end
    it 'com cancelamento' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 1.day.from_now,
            minimum_bid: 5, bids_difference: 10, created_by: creator_admin
        )
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )
        lot_item = LotItem.create!(lot: first_lot, item_model: item)
        first_lot.approved!
        travel 2.days

        login_as creator_admin
        visit root_path
        click_on 'Lotes expirados'
        within 'div#ABC123456' do
            click_on 'Cancelar'
        end

        expect(page).to have_content 'Lote Cancelado com Sucesso'
    end
end