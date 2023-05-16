first_admin = User.create!(email:'creator@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
second_admin = User.create!(email:'admin@leilaodogalpao.com.br', password:'12345678', registration_number: '36767455075')
client = User.create!(email:'client@email.com.br', password:'12345678', registration_number: '14538220620')

first_lot = Lot.create!(
    code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
    minimum_bid: 5, bids_difference: 10, status: 'approved',created_by: first_admin
) 
second_lot = Lot.create!(
    code:'DEF123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
    minimum_bid: 5, bids_difference: 10, status: 'approved',created_by: first_admin
) 
third_lot = Lot.create!(
    code:'GHI123456',start_date: 1.week.from_now,limit_date: 3.weeks.from_now,
    minimum_bid: 5, bids_difference: 10,created_by: first_admin
) 

first_item = ItemModel.create!(
    name:'Mochila',description:"Cor preta; À prova d'água",
    weight: 10, length: 20,width:5,depth:30,category:'Acessórios'
)

second_item = ItemModel.create!(
    name:'Vestido',description:'preto, tamanho P',
    weight: 100, length: 160,width:60,depth:10,category:'Roupas'
)

third_item = ItemModel.create!(
    name:'Sapato',description:'preto, tamanho 33',
    weight: 25, length: 10,width:5,depth:3,category:'Calçados'
)
