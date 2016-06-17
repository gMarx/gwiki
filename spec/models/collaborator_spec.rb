require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) { User.create!(email: 'test@test.com', password: 'helloworld', confirmed_at: Time.now) }
  let(:wiki) { Wiki.create!(title: 'Wiki Title', body: 'body of wiki', private: false, user: user)}
  let(:collaborator) { Collaborator.create!(wiki: wiki, user: user) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }
end
