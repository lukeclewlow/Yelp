require 'rails_helper'

describe Restaurant, :type => :model do 

	it 'is not valid with a name of less than 2 characters' do
		restaurant = Restaurant.new(name: "k")
		expect(restaurant).to have(1).error_on(:name)
		expect(restaurant).not_to be_valid
	end

end