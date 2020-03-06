require "rails_helper"

RSpec.describe "Static Pages", type: :system do
	describe "walking through Static Pages" do
		it "check layout links" do
			visit root_path
			expect(page).to have_link 'Home', href: root_path, count: 2
			expect(page).to have_link 'Help', href: help_path
			expect(page).to have_link 'About', href: about_path
			expect(page).to have_link 'Contact', href: contact_path			
		end	
	end	
end    