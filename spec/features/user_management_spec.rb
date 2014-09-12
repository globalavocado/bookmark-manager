require 'spec_helper'

feature "User signs up" do


		scenario "when being logged out" do
				expect { sign_up }.to change(User, :count).by(1)
				expect(page).to have_content("Welcome, alice@example.com")
				expect(User.first.email).to eq("alice@example.com")
		end

		scenario "with a password that doesn't match" do
			expect{ sign_up('a@a.com', 'pass', 'wrong') }.to change(User, :count).by(0)
			expect(current_path).to eq('/users')
			expect(page).to have_content("Sorry, your passwords don't match")
		end

		scenario "with an email that is already registered" do
			expect { sign_up }.to change(User, :count).by(1)
			expect { sign_up }.to change(User, :count).by(0)
			expect(page).to have_content("This email is already taken")
		end

end

feature "user is sent a new password" do

		before(:each) do
			User.create(:email => "test@test.com")
		end

		scenario "when they ask for a new password" do
			visit '/sessions/forgotten'
			expect(page).to have_content("forgotten password? please enter your email")
			click_button "submit"
			expect(current_path).to eq('/sessions/new')
			expect(page).to have_content("please check your email, a reset link has been sent to you.")
		end
end


