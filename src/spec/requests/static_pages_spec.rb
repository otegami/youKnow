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
            get static_pages_home_path
            expect(response).to have_http_status(200)
            assert_select "title", "Home | #{@base_title}"
        end 
    end
    describe "GET /static_pages/help" do
        it "shows /static-pages/help" do
            get static_pages_help_path
            expect(response).to have_http_status(200)
            assert_select "title", "Help | #{@base_title}"
        end    
    end
    describe "GET /static_pages/about" do
        it "shows /static_pages/about" do
            get static_pages_about_path
            expect(response).to have_http_status(200)
            assert_select "title", "About | #{@base_title}"
        end    
    end        
end    