require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { User.create!(email: 'test@test.com', password: 'helloworld', confirmed_at: Time.now) }
  let(:wiki) { Wiki.create!(title: 'Wiki Title', body: 'body of wiki', private: false, user: user)}

  describe 'attributes' do
     it 'responds to title' do
       expect(wiki).to respond_to(:title)
     end

     it 'responds to body' do
       expect(wiki).to respond_to(:body)
     end

     it 'responds to private' do
       expect(wiki).to respond_to(:private)
     end

     it 'responds to user' do
       expect(wiki).to respond_to(:user)
     end
   end
end
