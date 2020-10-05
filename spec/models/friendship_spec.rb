require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'Associations for friendship' do
    let(:friendship) { Friendship.new(confirmed: false) }

    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end

  it 'It is invalid without user and friend' do
    @friendship = Friendship.new
    expect(@friendship.save).to eq(false)
  end

  it 'It is invalid without confirmation' do
    @friendship = Friendship.new(confirmed: false)
    expect(@friendship.save).to eq(false)
  end
end
