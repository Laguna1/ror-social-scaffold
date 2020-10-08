require 'rails_helper'
RSpec.describe User, type: :model do
  context 'Associations for User' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
    it { should have_many(:friends_posts) }
    it { should have_many(:friends) }
    it { should have_many(:pending_friendships) }
    it { should have_many(:confirmed_friendships) }
    it { should have_many(:inverse_friends) }

  end

  context 'Validations for new User' do
    let(:user) { User.new(name: 'anyname', email: 'anyname@mail.com', password: 'password') }

    it 'It checks if user valid' do
      expect(user).to be_valid
    end
    it 'It is invalid if email is blank' do
      user.email = ''
      expect(user).not_to be_valid
    end
    it 'It invalid if name is blank' do
      user.name = ''
      expect(user).not_to be_valid
    end

    it 'It invalid if name is over than 20 symbols' do
      user.name = 'Loooooooooooooooooooooong Name'
      expect(user).not_to be_valid
    end
  end
end
