require 'rails_helper'

describe 'Administrador edita lote' do
    it 'mas não está autenticado' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: creator_admin
        )

        visit edit_lot_path(first_lot)

        expect(current_path).to eq new_user_session_path
    end
    it 'mas está com credencial errada' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        client = User.create!(email:'natalia@email.com.br', password:'12345678', registration_number: '87691734000')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: creator_admin
        )

        login_as client
        visit edit_lot_path(first_lot)

        expect(current_path).to eq root_path
        expect(page).to have_content 'Você não tem permissão para executar essa ação'
    end
    it 'mas o lote já foi aprovado' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, created_by: creator_admin
        )
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )
        lot_item = LotItem.create!(lot: first_lot, item_model: item)
        first_lot.approved!

        login_as creator_admin
        visit edit_lot_path(first_lot)

        expect(current_path).to eq lot_path(first_lot)
        expect(page).to have_content 'Lote não pode mais ser editado'
    end
    it 'com sucesso' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, created_by: creator_admin
        )
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )
        lot_item = LotItem.create!(lot: first_lot, item_model: item)
                
        login_as approver_admin
        visit root_path
        click_on 'Aprovar lotes'
        click_on 'Lote ABC123456'
        click_on 'Editar lote'
        fill_in 'Lance Mínimo', with: 15
        click_on 'Salvar'

        expect(page).to have_content 'Lote atualizado com sucesso'
        expect(page).not_to have_content "Lance Mínimo: R$ 5,00"
        expect(page).to have_content "Lance Mínimo: R$ 15,00"
    end
end