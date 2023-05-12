require 'rails_helper'

describe 'Visitante faz login' do
    it 'como admin' do
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        
        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: 'natalia@leilaodogalpao.com.br'
        fill_in 'Senha', with: '12345678'
        click_on 'Log in'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Login efetuado com sucesso.'
        within 'nav' do
            expect(page).to have_link 'Criar novo lote'
            expect(page).to have_link 'Criar novo item'
            expect(page).to have_link 'Aprovar lotes'
            expect(page).not_to have_link 'Ver resultados'
            expect(page).to have_button 'Sair'
        end
    end
    it 'como cliente' do
        client = User.create!(email:'natalia@email.com.br', password:'12345678', registration_number: '87691734000')
        
        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: 'natalia@email.com.br'
        fill_in 'Senha', with: '12345678'
        click_on 'Log in'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Login efetuado com sucesso.'
        within 'nav' do
            expect(page).not_to have_link 'Criar novo lote'
            expect(page).not_to have_link 'Criar novo item'
            expect(page).not_to have_link 'Aprovar lotes'
            expect(page).to have_link 'Ver resultados'
            expect(page).to have_button 'Sair'
        end
    end
    it 'e faz logout' do
        client = User.create!(email:'natalia@email.com.br', password:'12345678', registration_number: '87691734000')
        
        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: 'natalia@email.com.br'
        fill_in 'Senha', with: '12345678'
        click_on 'Log in'
        click_on 'Sair'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Logout efetuado com sucesso.'
        within 'nav' do
            expect(page).not_to have_link 'Ver resultados'
            expect(page).to have_link 'Entrar'
        end
    end
end