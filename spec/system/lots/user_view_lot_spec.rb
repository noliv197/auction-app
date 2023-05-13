require 'rails_helper'

describe 'Usuário vê lotes disponiveis' do 
    it 'na tela de inicio' do
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'approved',created_by:admin
        ) 
        second_lot = Lot.create!(
            code:'DEF123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'approved', created_by:admin
        ) 

        visit root_path

        within('section#inProgress') do
            expect(page).to have_link('Lote ABC123456')
        end
        within('section#future') do
            expect(page).to have_content('Lote DEF123456')
        end
    end
    it 'e seus detalhes' do
        formatted_star_date = I18n.localize(Date.today)
        formatted_limit_date = I18n.localize(3.days.from_now.to_date)
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        first_lot = Lot.create!(
            code:'ABC123456',start_date: formatted_star_date, limit_date: formatted_limit_date,
            minimum_bid: 5, bids_difference: 10, status: 'approved',created_by:admin
        ) 
        second_lot = Lot.create!(
            code:'DEF123456',start_date: formatted_star_date,limit_date: formatted_limit_date,
            minimum_bid: 5, bids_difference: 10, status: 'approved',created_by:admin
        ) 

        visit root_path
        click_on 'Lote ABC123456'

        expect(page).to have_content('Lote ABC123456')
        expect(page).to have_content("Data de Início: #{formatted_star_date}")
        expect(page).to have_content("Data Limite: #{formatted_limit_date}")
        expect(page).to have_content("Lance Mínimo: R$ 5,00")
        expect(page).to have_content("Itens do Lote")
    end
end