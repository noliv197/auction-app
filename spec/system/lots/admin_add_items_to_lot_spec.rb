require 'rails_helper'

describe 'Administrador adiciona items a um lote' do
    it 'com sucesso' do
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: admin
        ) 
        allow(SecureRandom).to receive(:alphanumeric).and_return('S54D8R2F5G')
        first_item = ItemModel.create!(name:'Carro',description:'Ferrari vermelha',
        weight: 700, length: 450,width:50,depth:15,category:'automóveis')
        allow(SecureRandom).to receive(:alphanumeric).and_return('5D1X2C98EF')
        second_item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )

        login_as admin
        visit lot_path(lot)
        click_on 'Adicionar Item'
        select 'Carro - S54D8R2F5G', from: 'Item'
        click_on 'Adicionar' 

        expect(page).to have_content('Item adicionado com sucesso!')
        expect(page).to have_content('Código: S54D8R2F5G')
        expect(page).to have_content("Nome: Carro")
        expect(page).to have_content("Categoria: automóveis")
        expect(page).to have_content("Descrição: Ferrari vermelha")
        expect(page).to have_content("Peso: 700g")
        expect(page).to have_content("Dimensões: 450cm x 50cm x 15cm")

    end
    it 'e deleta um item' do
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'pending', created_by: admin
        ) 
        allow(SecureRandom).to receive(:alphanumeric).and_return('S54D8R2F5G')
        first_item = ItemModel.create!(name:'Carro',description:'Ferrari vermelha',
        weight: 700, length: 450,width:50,depth:15,category:'automóveis')
        allow(SecureRandom).to receive(:alphanumeric).and_return('5D1X2C98EF')
        second_item = ItemModel.create!(
            name:'Mochila',description:"Cor preta; À prova d'água",
            weight: 10, length: 20,width:5,depth:30,category:'bolsas'
        )
        lot_item = LotItem.create!(lot: lot, item_model: first_item)

        login_as admin
        visit lot_path(lot)
        within('div#S54D8R2F5G') do
            click_on 'Excluir'
        end

        expect(page).to have_content('Item deletado com sucesso!')
        expect(page).not_to have_content('Código: S54D8R2F5G')
    end
end