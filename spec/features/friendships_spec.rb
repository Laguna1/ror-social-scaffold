require 'rails_helper'

RSpec.describe 'Friendships Features', type: :feature do
  let(:user1) { User.new(id: 21, name: 'Test_user', email: 'test_user@mail', password: 'anypassword') }
  let(:user2) { User.new(id: 12, name: 'Other_user', email: 'jother_user@mail', password: 'password') }
  let(:friendship) { Friendship.new(user_id: user1.id, friend_id: user2.id) }

  scenario 'User can send a friend request' do
    user1.save
    user2.save
    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Log in'
    visit users_path
    click_link 'Send Friendship'
    expect(page).to have_content('Name: Other_user')
  end

  scenario 'User can look profile page another user' do
    user1.save
    user2.save
    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Log in'
    visit users_path
    click_link 'See Profile', match: :first
    expect(page).to have_content('Recent posts')
  end
end
