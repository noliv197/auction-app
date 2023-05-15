require 'rails_helper'

describe 'Cliente faz um lance' do
    it 'mas não está autenticado' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '36767455075')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        lot = Lot.create!(
            code:'ABC123456',start_date: Date.today,limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'approved', created_by: creator_admin, approved_by: approver_admin
        )

        visit root_path
        click_on 'ABC123456'

        expect(page).not_to have_css 'form'
        expect(page).not_to have_content 'Confirmar'
    end
    it 'e é o primeiro lance' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '36767455075')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')
        lot = Lot.create!(
            code:'ABC123456',start_date: Date.today,limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'approved', created_by: creator_admin, approved_by: approver_admin
        )

        login_as client
        visit root_path
        click_on 'ABC123456'
        fill_in 'Lance', with: 6
        click_on 'Confirmar'

        expect(page).to have_content 'Lance feito com sucesso'
        expect(page).to have_content 'Último Lance: R$ 6,00'
    end
    it 'e é o segundo lance' do
        creator_admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '36767455075')
        approver_admin = User.create!(email:'ana@leilaodogalpao.com.br', password:'12345678', registration_number: '14538220620')
        first_client = User.create!(email:'natalia@email.com', password:'12345678', registration_number: '87691734000')
        second_client = User.create!(email:'ana@email.com', password:'12345678', registration_number: '36529634070')
        lot = Lot.create!(
            code:'ABC123456',start_date: Date.today,limit_date: 3.days.from_now,
            minimum_bid: 5, bids_difference: 10, status: 'approved', created_by: creator_admin, approved_by: approver_admin
        )
        first_bid = Bid.create!(user: first_client, lot: lot, value: 6)
        
        login_as second_client
        visit root_path
        click_on 'ABC123456'
        fill_in 'Lance', with: 16
        click_on 'Confirmar'

        expect(page).not_to have_content 'Último Lance: R$ 6,00'
        expect(page).to have_content 'Último Lance: R$ 16,00'
        expect(page).to have_content 'Lance feito com sucesso'
    end
end