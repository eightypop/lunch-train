require 'rails_helper'

feature "LoginLogouts", :type => :feature do

  background do
    create :rider, email: 'test@test.test', password: 'fiddlesticks'
  end

  scenario 'user login with email/password then logout' do
      visit '/riders/sign_in'
      expect(page).to have_content('Log in')
      within '#new_rider' do
        fill_in 'rider_email', with: 'test@test.test'
        fill_in 'rider_password', with: 'fiddlesticks'
      end
      click_button 'Log in'
      expect(page).to have_content('Welcome to lunch train!')
      expect(page).to have_button('Logout')
      click_button 'Logout'
      expect(page).to have_content('Signed out successfully')

  end

  scenario 'user login with email/password fails' do
    visit '/riders/sign_in'
    expect(page).to have_content('Log in')
    within '#new_rider' do
      fill_in 'rider_email', with: 'test@test.test'
      fill_in 'rider_password', with: 'wrong'
    end
    click_button 'Log in'
    expect(page).to have_content('Invalid email or password.')
    within '#new_rider' do
      fill_in 'rider_email', with: 'test@.test'
      fill_in 'rider_password', with: 'wrong'
    end
    click_button 'Log in'
    expect(page).to have_content('Invalid email or password.')
  end

end
