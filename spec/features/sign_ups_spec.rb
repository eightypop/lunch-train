require 'rails_helper'

feature "SignUps", :type => :feature do
    scenario 'singing up with unique email and a name' do
      visit '/riders/sign_up'

      within '#new_rider' do
        fill_in 'Name', with: 'Bob'
        fill_in 'rider_email', with: 'test@123.org'
        fill_in 'rider_password', with: 'password'
        fill_in 'rider_password_confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_content('Welcome to lunch train!')
      expect(current_path).to eq('/')

    end
end
