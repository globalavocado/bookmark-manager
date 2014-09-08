require 'spec_helper'

feature "User browses the list of links" do

	before(:each) {
		Link.create(:url => "http://www.makersacademy.com",
					:title => "Makers Academy")
	}

	scenario "when opening the homepage" do
		visit '/'		
		p page.title
		expect(page).to have_content("Makers Academy")
	end


end