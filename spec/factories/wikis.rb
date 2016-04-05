FactoryGirl.define do
  factory :wiki do
    title "MyString"
    body "MyText"
    private false
    # calls factory girl user
    user
  end
end
