require 'rails_helper'

feature 'endorsing reviews' do
	
	before do
		kfc = Restaurant.create(name: 'KFC')
		kfc.reviews.create(rating: 3, thoughts: 'It was delish like a fish')
	end

	scenario 'a user can endorse a review, which updates the review endorsement count' do
		sign_up('a@a.com')
		click_link 'Endorse KFC'
		expect(page).to have_content('1 endorsement')
	end

end