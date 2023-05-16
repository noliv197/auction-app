require 'rails_helper'

describe 'Administrador aprova lote' do
    it 'mas não está autenticado' do
        visit pending_lots_path

        expect(current_path).to eq new_user_session_path
    end
    it 'mas está com credencial errada' do
        client = User.create!(email:'natalia@email.com.br', password:'12345678', registration_number: '87691734000')
        
        login_as client
        visit pending_lots_path

        expect(current_path).to eq root_path
        expect(page).to have_content 'Você não tem permissão para executar essa ação'
    end
    it 'mas não tem autorização' do
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: admin
        ) 

        login_as admin
        visit root_path
        click_on 'Aprovar lotes'
        within 'div#ABC123456' do
            click_on 'Aprovar'
        end

        expect(page).to have_content 'Lote ABC123456'
        expect(page).to have_content 'Outro administrador precisa executar essa ação'
    end
    it 'com sucesso' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: creator_admin
        ) 
        second_lot = Lot.create!(
            code:'DEF123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: creator_admin
        ) 
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )
        lot_item = LotItem.create!(lot: first_lot, item_model: item)
        
        login_as approver_admin
        visit root_path
        click_on 'Aprovar lotes'
        within 'div#ABC123456' do
            click_on 'Aprovar'
        end

        expect(page).not_to have_content 'Lote ABC123456'
        expect(page).to have_content 'Lote DEF123456'
        expect(page).to have_content 'Lote Aprovado com Sucesso'
    end
end