require 'rails_helper'

RSpec.describe 'Log In Features', type: :feature do
  let(:user) { User.new(name: 'newlog', email: 'user@site.com', password: 'some123pass') }

  scenario 'User cannot log in with empty email field' do
    user.save
    visit new_user_session_path
    fill_in 'Email', with: nil
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'User can log in when his account already exists' do
    user.save
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
  end

  scenario 'User cannot log in with empty password field' do
    user.save
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: nil
    click_button 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end
end
