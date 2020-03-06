require "rails_helper"

RSpec.describe "Static Pages", type: :request do
	before do
		@base_title = "youKnow"
	end        
	describe "Get /" do
		it "show /static_pages/home" do
			get root_url
			expect(response).to have_http_status(200)
		end               
	end        
	describe "Get /static_pages/home" do
		it "shows /static_pages/home" do
			get home_path
			expect(response).to have_http_status(200)
			assert_select "title", "#{@base_title}"
		end 
	end
	describe "GET /static_pages/help" do
		it "shows /static-pages/help" do
			get help_path
			expect(response).to have_http_status(200)
			assert_select "title", "Help | #{@base_title}"
		end    
	end
	describe "GET /static_pages/about" do
		it "shows /static_pages/about" do
			get about_path
			expect(response).to have_http_status(200)
			assert_select "title", "About | #{@base_title}"
		end    
	end
	describe "GET /static_pages/contact" do
		it "shows /static_pages/contact" do
			get contact_path
			expect(response).to have_http_status(200)
			assert_select "title", "Contact | #{@base_title}"
		end	
	end		
end    