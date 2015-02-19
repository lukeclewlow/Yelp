def sign_up(email)
	visit '/restaurants'
	click_link('Sign up')
  fill_in('Email', with: email)
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def create_restaurant(name)
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
end

def create_review(restaurant, thoughts, rating)
	click_link "Review #{restaurant}"
	fill_in 'Thoughts', with: thoughts
	select rating, from: 'Rating'
	click_button 'Leave Review'
end