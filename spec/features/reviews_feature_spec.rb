require 'rails_helper'

feature 'reviewing' do
	
	before {Restaurant.create name: 'KFC'}
	before {Restaurant.create name: 'Burger King'}

	scenario 'allows users to leave a review using a form' do
		sign_up('user1@example.com')
		click_link 'Review KFC'
		fill_in "Thoughts", with: "so so"
		select '3', from: 'Rating'
		click_button 'Leave Review'

		expect(current_path).to eq '/restaurants'
		expect(page).to have_content('so so')
	end

	scenario 'deleting restaurant deletes all reviews' do
		sign_up('user1@example.com')
		create_restaurant('Subway')
		click_link 'Review Subway'
		fill_in "Thoughts", with: "so so"
		select '3', from: 'Rating'
		click_button 'Leave Review'
		click_link 'Delete Subway'

		expect(page).not_to have_content 'Subway'
		expect(page).to have_content 'No reviews.'
	end


end