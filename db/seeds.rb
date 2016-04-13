# create 50 wikis
50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence ,
    body: Faker::Lorem.paragraph,
    user_id: 1
  )
end

puts 'Seeds finished'
puts "#{Wiki.count} Wikis created."
