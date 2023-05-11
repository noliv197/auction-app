require 'rails_helper'

RSpec.describe ItemModel, type: :model do
    describe '#valid?' do
        context 'com campo vazio:' do
            it 'nome' do
                item_model = ItemModel.new(
                    name:'',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: 700, length: 450,width:50,depth:15,category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
            it 'descrição' do
                item_model = ItemModel.new(
                    name:'Carro',description:'',image:'no_image_available.jpg',
                    weight: 700, length: 450,width:50,depth:15,category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
            it 'imagem' do
                item_model = ItemModel.new(
                    name:'Carro',description:'Ferrari vermelha',image:'',
                    weight: 700, length: 450,width:50,depth:15,category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
            it 'peso' do
                item_model = ItemModel.new(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: '', length: 450,width:50,depth:15,category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
            it 'altura' do
                item_model = ItemModel.new(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: 700, length: '',width:50,depth:15,category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
            it 'largura' do
                item_model = ItemModel.new(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: 700, length: 450,width:'',depth:15,category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
            it 'profundidade' do
                item_model = ItemModel.new(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: 700, length: 450,width:50,depth:'',category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
            it 'categoria' do
                item_model = ItemModel.new(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: 700, length: 450,width:50,depth:15,category:''
                )

                expect(item_model.valid?).to eq false
            end
        end
        context 'regra específica:' do
            it 'código é único' do
                first_model = ItemModel.create!(
                    name:'Mochila',description:"Cor preta; À prova d'água",image:'no_image_available.jpg',
                    weight: 10, length: 20,width:5,depth:30,category:'bolsas'
                )
                second_model = ItemModel.create!(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: 700, length: 450,width:50,depth:15,category:'automóveis'
                )

                expect(first_model.code).not_to eq second_model
            end
            it 'código não pode ser modificado único' do
                item_model = ItemModel.create!(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: 700, length: 450,width:50,depth:15,category:'automóveis'
                )
                original_code = item_model.code
                item_model.update!(weight:500)

                expect(original_code).to eq item_model.code
            end
            it 'peso maior que 0' do
                item_model = ItemModel.new(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: -1, length: 450,width:50,depth:15,category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
            it 'altura maior que 0' do
                item_model = ItemModel.new(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: 700, length: -1,width:50,depth:15,category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
            it 'comprimento maior que 0' do
                item_model = ItemModel.new(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: 700, length: 450,width:-1,depth:15,category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
            it 'profundidade maior que 0' do
                item_model = ItemModel.new(
                    name:'Carro',description:'Ferrari vermelha',image:'no_image_available.jpg',
                    weight: 700, length: 450,width:50,depth:-1,category:'automóveis'
                )

                expect(item_model.valid?).to eq false
            end
        end
    end
end
