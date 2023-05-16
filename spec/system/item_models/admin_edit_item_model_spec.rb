require 'rails_helper'

describe 'Administrador edita item' do
    it 'mas não está autenticado' do
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )

        visit edit_item_model_path(item)

        expect(current_path).to eq new_user_session_path
    end
    it 'mas está com credencial errada' do
        client = User.create!(email:'natalia@email.com.br', password:'12345678', registration_number: '87691734000')
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )

        login_as client
        visit edit_item_model_path(item)

        expect(current_path).to eq root_path
        expect(page).to have_content 'Você não tem permissão para executar essa ação'
    end
    it 'mas o item não pode mais ser modificado' do
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas',
            status: 'unavailable'
        )

        login_as admin
        visit edit_item_model_path(item)

        expect(current_path).to eq item_model_path(item)
        expect(page).to have_content 'Item não pode mais ser editado'
    end
    it 'com sucesso' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, created_by: creator_admin
        )
        allow(SecureRandom).to receive(:alphanumeric).and_return('ASE54D6D8D')
        item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )
        lot_item = LotItem.create!(lot: first_lot, item_model: item)
                
        login_as creator_admin
        visit root_path
        click_on 'Aprovar lotes'
        click_on 'Lote ABC123456'
        click_on 'ASE54D6D8D'
        click_on 'Editar item'
        fill_in 'Categoria', with: 'Acessórios'
        click_on 'Salvar'

        expect(page).to have_content 'Item atualizado com sucesso'
        expect(page).not_to have_content "Categoria: bolsas"
        expect(page).to have_content "Categoria: Acessórios"
    end
end