require 'rails_helper'

feature "Ratings", :type => :feature do
  background do
    create :rider, email: 'test@test.test', password: 'fiddlesticks'
    create :station, id: 1
  end

  scenario 'user rates a station' do
    visit '/riders/sign_in'
    expect(page).to have_content('Log in')
    within '#new_rider' do
      fill_in 'rider_email', with: 'test@test.test'
      fill_in 'rider_password', with: 'fiddlesticks'
    end
    click_button 'Log in'

    click_link 'Edit ratings'
    expect(current_path).to eq '/stations'

    expect(page).to have_content('Chipotle')

    expect(page).to have_selector('#station_1_rating[value="0"]')

    within '#station_1' do
      find('#station_1_rating').set 33
      click_button 'update'
    end

    expect(page).to have_content('Chipotle')

    expect(page).to have_selector('#station_1_rating[value="33"]')

  end
end
