require 'rails_helper'

feature 'restaurants' do

	context 'no restaurants have been added' do	

		scenario 'should display a prompt to add a restaurant' do
			sign_up('user1@example.com')
			expect(page).to have_content 'No restaurants'
			expect(page).to have_link 'Add a restaurant'
		end

	end

	context 'restaurants have been added' do
		before do
			Restaurant.create(name: 'KFC')
		end

		scenario 'display restaurants' do
			visit '/restaurants'
			expect(page).to have_content('KFC')
			expect(page).not_to have_content('No restaurants yet')
		end
	end

	context 'creating restaurants' do

		scenario 'prompts user to fill out a form, then displays the new restaurant' do
			sign_up('user1@example.com')
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
			expect(page).to have_content('KFC')
			expect(current_path).to eq '/restaurants'
		end

		scenario 'A user must be logged in to create restaurants' do
			visit '/restaurants'
			expect(page).not_to have_content 'Add a restaurant'
		end

		context 'an invalid restaurant' do
		
			scenario 'does not let you submit a name that is 1 character' do
				sign_up('user1@example.com')
				click_link 'Add a restaurant'
				fill_in 'Name', with: 'k'
				click_button 'Create Restaurant'
				expect(page).not_to have_css 'h2', text: 'k'
				expect(page).to have_content 'error'
			end

			scenario 'it is not valid unless it has unique name' do
				Restaurant.create(name: "Moe's Tavern")
				restaurant = Restaurant.new(name: "Moe's Tavern")
				expect(restaurant).to have(1).error_on(:name)
			end

		end

	end

	context 'viewing restaurants' do

		let!(:kfc){ Restaurant.create(name:'KFC') }

		scenario 'lets a user view a restaurant' do
			visit '/restaurants'
			click_link 'KFC'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq "/restaurants/#{kfc.id}"
		end

	end

	context 'editing restaurants' do

		scenario 'let a user edit a restaurant' do
			sign_up('user1@example.com')
			create_restaurant("JFC")
			click_link "Edit JFC"
			fill_in 'Name', with: 'Jentucky Fried Chicken'
			click_button 'Update Restaurant'
			expect(page).to have_content 'Jentucky Fried Chicken'
			expect(current_path).to eq '/restaurants'
		end
	end

	context 'deleting restaurants' do

		before { Restaurant.create name: 'KFC' }

		# scenario 'removes a restaurant when a user clicks a delete link' do
		# 	visit '/restaurants'
		# 	click_link 'Delete KFC'
		# 	expect(page).not_to have_content 'KFC'
		# 	expect(page).to have_content 'Restaurant deleted successfully'
		# end

		scenario 'a user can only edit, delete, review if they are logged in' do
			visit '/restaurants'
			expect(page).not_to have_content 'Review KFC'
			sign_up('user1@example.com')
			expect(page).to have_content 'Review KFC'
		end

		scenario "Users can only edit/delete restaurants which they've created" do
			sign_up('user1@example.com')
			create_restaurant('PFC')
			expect(page).to have_content 'Edit PFC'
			click_link 'Sign out'
			sign_up('user2@example.com')
			expect(page).not_to have_content 'Edit PFC'
		end


	end

end




















