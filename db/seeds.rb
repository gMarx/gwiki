# create 50 wikis
50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user_id: 1
  )
end

10.times do
  User.create!(
    email: Faker::Internet.email,
    confirmed_at: Faker::Time.between(DateTime.now - 4, DateTime.now),
    role: 0,
    password: Faker::Internet.password
  )
end

puts 'Seeds finished'
puts "#{Wiki.count} Wikis created."
