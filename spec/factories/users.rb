FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| 'testemail' + n.to_s + '@test.com' }
    password 'helloworld'
    password_confirmation 'helloworld'
    confirmed_at Time.now
  end
end
