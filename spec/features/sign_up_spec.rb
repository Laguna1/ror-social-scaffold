require 'rails_helper'

RSpec.describe 'Sign Up Features', type: :feature do
  scenario 'it is possible for user to create account' do
    visit new_user_registration_path
    fill_in 'Name', with: 'test_user'
    fill_in 'Email', with: 'test_user@mail'
    fill_in 'Password', with: 'anypassword'
    fill_in 'Password confirmation', with: 'anypassword'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
  scenario 'the name field must be filled for user\`s sign up' do
    visit new_user_registration_path
    fill_in 'Name', with: nil
    fill_in 'Email', with: 'test_user@mail'
    fill_in 'Password', with: 'anypassword'
    fill_in 'Password confirmation', with: 'anypassword'
    click_button 'Sign up'
    expect(page).to have_content("Name can\'t be blank")
  end
  scenario 'the email field must be filled for user\`s sign up' do
    visit new_user_registration_path
    fill_in 'Name', with: 'test_user'
    fill_in 'Email', with: nil
    fill_in 'Password', with: 'anypassword'
    fill_in 'Password confirmation', with: 'anypassword'
    click_button 'Sign up'
    expect(page).to have_content("Email can\'t be blank")
  end
  scenario 'the password field must be filled for user\`s sign up' do
    visit new_user_registration_path
    fill_in 'Name', with: 'test_user'
    fill_in 'Email', with: 'test_user@mail'
    fill_in 'Password', with: nil
    fill_in 'Password confirmation', with: 'anypassword'
    click_button 'Sign up'
    expect(page).to have_content("Password can\'t be blank")
  end
  scenario 'sign up is impossible if the password and confirmation are not identical' do
    visit new_user_registration_path
    fill_in 'Name', with: 'test_user'
    fill_in 'Email', with: 'test_user@mail'
    fill_in 'Password', with: 'anypassword'
    fill_in 'Password confirmation', with: 'apasswordny'
    click_button 'Sign up'
    expect(page).to have_content("Password confirmation doesn\'t match Password")
  end
end
