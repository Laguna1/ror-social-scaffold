require 'rails_helper'

RSpec.describe 'Posts Features', type: :feature do
  let(:user) do
    User.new(name: 'user0', email: 'user0@mail',
             password: 'password', password_confirmation: 'password')
  end
  let(:user1) do
    User.new(name: 'user1', email: 'user1@mail',
             password: 'password', password_confirmation: 'password')
  end
  let(:user2) do
    User.new(name: 'user2', email: 'user2@mail',
             password: 'password', password_confirmation: 'password')
  end
  let(:test_friendship) { Friendship.new(user_id: user.id, friend_id: user2.id, confirmed: true) }
  let(:inverse_test_friendship) { Friendship.new(user_id: user2.id, friend_id: user.id, confirmed: true) }
  let(:test_post0) { Post.new(user_id: user.id, content: 'My first post in Stay In Touch!') }
  let(:test_post1) { Post.new(user_id: user2.id, content: 'Hello') }
  let(:test_post2) { Post.new(user_id: user1.id, content: 'Nice to be here!') }

  def save_in_database
    user.save
    user1.save
    user2.save
    test_friendship.save
    inverse_test_friendship.save
    test_post0.save
    test_post1.save
    test_post2.save
  end

  def log_in
    visit root_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'Timeline page showws posts from the user' do
    save_in_database
    log_in
    expect(page).to have_selector 'p', text: 'My first post in Stay In Touch!'
  end

  scenario "Timeline page shows the post from the user's friend" do
    save_in_database
    log_in
    expect(page).to have_selector 'p', text: 'Hello'
  end

  scenario "Timeline page doesn't show the post from 'no-friends'" do
    save_in_database
    log_in
    expect(page).to_not have_selector 'p', text: 'Nice to be here!'
  end
end
