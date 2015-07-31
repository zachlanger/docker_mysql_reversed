require 'rails_helper'

feature 'Cars' do
  scenario 'can be created' do
    visit '/'

    click_link 'New Car'

    fill_in 'Make', with: 'Maserati'
    fill_in 'Model', with: 'Grandturismo'
    fill_in 'Year', with: '2015'
    fill_in 'Price', with: '132000'

    click_button 'Create Car'

    expect(page).to have_content('Car has been created')
  end
end
