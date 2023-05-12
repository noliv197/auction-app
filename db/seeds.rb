admin = User.create!(email:'natalia@leilaodogalpao.com.br', password:'12345678', registration_number: '87691734000')
client = User.create!(email:'ana@email.com.br', password:'12345678', registration_number: '14538220620')
first_lot = Lot.create!(
    code:'ABC123456',start_date: Date.today, limit_date: 3.days.from_now,
    minimum_bid: 5, bids_difference: 10, status: 'approved'
) 
second_lot = Lot.create!(
    code:'DEF123456',start_date: 1.day.from_now,limit_date: 3.days.from_now,
    minimum_bid: 5, bids_difference: 10, status: 'approved'
) 
third_lot = Lot.create!(
    code:'GHI123456',start_date: 1.week.from_now,limit_date: 3.weeks.from_now,
    minimum_bid: 5, bids_difference: 10
) 