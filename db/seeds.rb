User.create!(
  name: 'Deepak Mahakale',
  email: 'deepak@weboapps.com',
  api_key: 'abcdefgh12345678abcdefgh'
)

10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.safe_email,
    api_key: Faker::Lorem.characters(24)
  )
end
