require 'rails_helper'

describe 'Visitante se cadastra' do
    context 'com credenciais de admin' do
        it 'com sucesso' do
            visit root_path
            click_on 'Entrar'
            click_on 'Fazer cadastro'
            fill_in 'Email', with: 'ana@leilaodogalpao.com.br'
            fill_in 'CPF', with: '14538220620'
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirme sua senha', with: '12345678'
            click_on 'Fazer cadastro'

            expect(current_path).to eq root_path
            expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
            within 'nav' do
                expect(page).to have_link 'Criar novo lote'
                expect(page).to have_link 'Criar novo item'
                expect(page).to have_link 'Aprovar lotes'
            end
        end
        it 'com fracasso' do
            visit root_path
            click_on 'Entrar'
            click_on 'Fazer cadastro'
            fill_in 'Email', with: 'ana@leilaodogalpao.com.br'
            fill_in 'CPF', with: ''
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirme sua senha', with: '12345678'
            click_on 'Fazer cadastro'

            expect(page).to have_content 'Não foi possível salvar usuário'
            expect(page).to have_content 'CPF não pode ficar em branco'
        end
    end
    context 'com credenciais de cliente' do
        it 'com sucesso' do
            visit root_path
            click_on 'Entrar'
            click_on 'Fazer cadastro'
            fill_in 'Email', with: 'ana@email.com'
            fill_in 'CPF', with: '14538220620'
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirme sua senha', with: '12345678'
            click_on 'Fazer cadastro'

            expect(current_path).to eq root_path
            expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
            within 'nav' do
                expect(page).not_to have_link 'Criar novo lote'
                expect(page).not_to have_link 'Criar novo item'
                expect(page).not_to have_link 'Aprovar lotes'
                expect(page).to have_link 'Ver resultados'
            end
        end
        it 'com fracasso' do
            visit root_path
            click_on 'Entrar'
            click_on 'Fazer cadastro'
            fill_in 'Email', with: 'ana@email.com'
            fill_in 'CPF', with: ''
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirme sua senha', with: '12345678'
            click_on 'Fazer cadastro'

            expect(page).to have_content 'Não foi possível salvar usuário'
            expect(page).to have_content 'CPF não pode ficar em branco'
        end
    end
end