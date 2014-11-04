require 'rails_helper'

feature "SignUps", :type => :feature do
    scenario 'signing up with unique email and a name' do
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

  scenario 'sign up fail because invalid name' do
    visit '/riders/sign_up'

    within '#new_rider' do
      fill_in 'rider_email', with: 'test@123.org'
      fill_in 'rider_password', with: 'password'
      fill_in 'rider_password_confirmation', with: 'password'
    end
    click_button 'Sign up'
    expect(page).to have_content('Name can\'t be blank')
    expect(current_path).to eq('/riders')
  end

    scenario 'sign up fail because invalid email' do
      visit '/riders/sign_up'

      within '#new_rider' do
        fill_in 'rider_name', with: 'My Name'
        fill_in 'rider_password', with: 'password'
        fill_in 'rider_password_confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_content('Email can\'t be blank')
      expect(current_path).to eq('/riders')
    end

    scenario 'sign up fail because invalid password' do
      visit '/riders/sign_up'

      within '#new_rider' do
        fill_in 'rider_name', with: 'My Name'
        fill_in 'rider_email', with: 'test@123.org'
        fill_in 'rider_password_confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_content('Password can\'t be blank')
      expect(current_path).to eq('/riders')
    end

    scenario 'sign up fail because too short password' do
      visit '/riders/sign_up'

      within '#new_rider' do
        fill_in 'rider_name', with: 'My Name'
        fill_in 'rider_email', with: 'test@123.org'
        fill_in 'rider_password', with: 'small'
        fill_in 'rider_password_confirmation', with: 'small'
      end
      click_button 'Sign up'
      expect(page).to have_content('Password is too short')
      expect(current_path).to eq('/riders')
    end

    scenario 'sign up fail because password confirm does not match' do
      visit '/riders/sign_up'

      within '#new_rider' do
        fill_in 'rider_name', with: 'My Name'
        fill_in 'rider_email', with: 'test@123.org'
        fill_in 'rider_password', with: 'password'
        fill_in 'rider_password_confirmation', with: 'small'
      end
      click_button 'Sign up'
      expect(page).to have_content('Password confirmation doesn\'t match')
      expect(current_path).to eq('/riders')
    end

    background do
      create :rider, email: 'inuse@taken.net'
    end

    scenario 'sign up fail because email address already in use' do
      visit '/riders/sign_up'

      within '#new_rider' do
        fill_in 'rider_name', with: 'My Name'
        fill_in 'rider_email', with: 'inuse@taken.net'
        fill_in 'rider_password', with: 'password'
        fill_in 'rider_password_confirmation', with: 'password'
      end
      click_button 'Sign up'
      expect(page).to have_content('Email has already been taken')
      expect(current_path).to eq('/riders')
    end
end
