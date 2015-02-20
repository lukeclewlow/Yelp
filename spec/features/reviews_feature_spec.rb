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

	scenario 'users can only leave one review per resturant' do
		sign_up('user1@example.com')
		create_restaurant('Subway')
		create_review('Subway', 'Great', 5)
		expect(page).not_to have_content 'Review Subway'
		expect(page).to have_content 'Delete Subway Review'
	end

	scenario 'users can only delete their own reviews' do
		sign_up('user1@example.com')
		create_restaurant('Subway')
		create_review('Subway', 'Great', 5)
		expect(page).to have_content 'Delete Review'
		click_link "Sign out"
		sign_up('user2@example.com')
		expect(page).not_to have_content 'Delete Review'
	end

	scenario 'displays an average rating for all reviews' do
		sign_up('user1@example.com')
		create_restaurant('BK')
		create_review('BK','So So', '3')
		click_link "Sign out"
		sign_up('user2@example.com')
		create_review('BK', 'Great', '5')
		expect(page).to have_content('Average rating: ★★★★')
	end

end