require 'rails_helper'

feature "Ratings", type: :feature, js: true do
  background do
    create :rider, email: 'test@test.com', password: 'fiddlesticks'
    create :station, id: 1
  end

  scenario 'user rates a station' do

    expect(Rider.first).to have_attributes(email: 'test@test.com')


    visit '/riders/sign_in'
    expect(page).to have_content('Log in')
    within '#new_rider' do
      fill_in 'Email', with: "test@test.com"
      fill_in 'Password', with: "fiddlesticks"

    end

    click_button 'Log in'

    expect(current_path).to eq('/')
    click_link 'Edit ratings'
    expect(current_path).to eq '/stations'

    find(:css, '[data-station="1"]').set 40

    wait_for_ajax

    visit '/stations'

    expect(page).to have_selector('[data-station="1"][value="40"]')
  end
end
