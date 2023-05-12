require 'rails_helper'

describe 'Administrador registra novo modelo de item' do
    it 'mas não está autenticado' do
        visit new_item_model_path

        expect(current_path).to eq new_user_session_path
    end
    it 'mas está com credencial errada' do
        client = User.create!(email:'natalia@email.com.br', password:'12345678', registration_number: '87691734000')
        
        login_as client
        visit new_item_model_path

        expect(current_path).to eq root_path
    end
    it 'com sucesso' do
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
        allow(SecureRandom).to receive(:alphanumeric).and_return('ASE54D6D8D')

        login_as admin
        visit root_path
        click_on 'Criar novo item'
        fill_in 'Nome', with: 'Vestido'
        fill_in 'Descrição', with: 'preto, tamanho M'
        fill_in 'Imagem', with: 'no_image_available.jpg'
        fill_in 'Peso', with: 5
        fill_in 'Altura', with: 3
        fill_in 'Largura', with: 2
        fill_in 'Profundidade', with: 1
        fill_in 'Categoria', with: 'Roupas'
        click_on 'Criar item'

        expect(page).to have_content('Item criado com sucesso!')
        expect(page).to have_content('Código: ASE54D6D8D')
        expect(page).to have_content("Categoria: Roupas")
        expect(page).to have_content("Nome: Vestido")
        expect(page).to have_content("Descrição: preto, tamanho M")
        expect(page).to have_content("Peso: 5g")
        expect(page).to have_content("Dimensões: 3cm x 2cm x 1cm")
    end
    it 'com fracasso' do
        admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')

        login_as admin
        visit root_path
        click_on 'Criar novo item'
        fill_in 'Nome', with: ''
        fill_in 'Descrição', with: 'preto, tamanho M'
        fill_in 'Imagem', with: 'no_image_available.jpg'
        fill_in 'Peso', with: -1
        fill_in 'Altura', with: 3
        fill_in 'Largura', with: 2
        fill_in 'Profundidade', with: 1
        fill_in 'Categoria', with: 'Roupas'
        click_on 'Criar item'

        expect(page).to have_content('Não foi possível cadastrar o item')
        expect(page).to have_content('Verifique os erros abaixo:')
        expect(page).to have_content("Nome não pode ficar em branco")
        expect(page).to have_content("Peso deve ser maior que 0")
    end
end