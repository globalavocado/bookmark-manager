require 'spec_helper'
require_relative 'helper/session'

	include SessionHelpers

feature "User signs up" do

		before(:each) do
		User.create(:email => 'alice@example.com')
		end
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
			expect(page).to have_content("Forgotten password? please enter your email")
			click_button "submit"
			expect(current_path).to eq('/sessions/reset_password')
			expect(page).to have_content("please check your email, a reset link has been sent to you.")
		end

end



feature "User signs in" do

	before(:each) do
		User.create(:email => 'test@test.com',
									:password => 'test',
									:password_confirmation => 'test')
	end

	scenario "with correct credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'test')
		expect(page).to have_content("Welcome, test@test.com")
	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in('test@test.com', 'wrong')
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end

feature 'User signs out' do

	before(:each) do
		User.create(:email => "test@test.com",
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario 'while being signed out' do
		sign_in('test@test.com', 'test')
		click_button "sign out"
		expect(page).to have_content("Goodbye!") 
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end
