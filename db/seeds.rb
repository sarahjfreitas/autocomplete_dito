100.times do 
  Event.create(name: Faker::Name.name, timestamps: Faker::Date.backward(2000) )
end