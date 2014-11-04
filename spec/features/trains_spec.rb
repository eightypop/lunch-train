require 'rails_helper'

feature "Trains", :type => :feature do
  background do
    create :rider, email: 'test@test.test', password: 'fiddlesticks'
    create :train
  end

  scenario 'user joins a train' do
    visit '/riders/sign_in'
    expect(page).to have_content('Log in')
    within '#new_rider' do
      fill_in 'rider_email', with: 'test@test.test'
      fill_in 'rider_password', with: 'fiddlesticks'
    end
    click_button 'Log in'

    click_link 'Join a train'
    expect(current_path).to eq '/trains'
    expect(page).to have_content('Trains')

    save_screenshot('/Users/mthompson/Desktop/file.png')

    expect(page).to have_link('Show')
    click_link 'Show'

    expect(current_path).to eq '/trains/1'
    click_button 'get on this train'

    expect(page).to have_button('get off this train')

  end
end
