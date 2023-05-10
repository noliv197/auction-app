require 'rails_helper'

describe 'Administrador registra novo lote' do
    it 'com sucesso' do
        # autenticar
        formatted_star_date = I18n.localize(Date.today)
        formatted_limit_date = I18n.localize(3.days.from_now.to_date) 

        visit root_path
        click_on 'Criar novo lote'
        fill_in 'Código', with: 'ABC123456'
        fill_in 'Data de Início', with: formatted_star_date
        fill_in 'Data Limite', with: formatted_limit_date
        fill_in 'Lance Mínimo', with: 5
        fill_in 'Diferença Mínima Entre Lotes', with: 2
        click_on 'Criar Lote'

        expect(page).to have_content('Lote criado com sucesso!')
        expect(page).to have_content('Lote ABC123456')
        expect(page).to have_content("Data de Início: #{formatted_star_date}")
        expect(page).to have_content("Data Limite: #{formatted_limit_date}")
        expect(page).to have_content("Lance Mínimo: R$ 5,00")
    end
    it 'com fracasso' do
        # autenticar
        formatted_star_date = I18n.localize(Date.today)
        formatted_limit_date = I18n.localize(3.days.from_now.to_date) 

        visit root_path
        click_on 'Criar novo lote'
        fill_in 'Código', with: ''
        fill_in 'Data de Início', with: formatted_star_date
        fill_in 'Data Limite', with: formatted_limit_date
        fill_in 'Lance Mínimo', with: 0
        fill_in 'Diferença Mínima Entre Lotes', with: 2
        click_on 'Criar Lote'

        expect(page).to have_content('Não foi possível cadastrar o lote')
        expect(page).to have_content('Verifique os erros abaixo:')
        expect(page).to have_content("Código não pode ficar em branco")
        expect(page).to have_content("Lance Mínimo deve ser maior que 0")
    end
end