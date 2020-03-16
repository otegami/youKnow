require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /signup" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "Post /signup" do
    before do
      get signup_path
    end  

    context "when the data is invalid " do
      it "should return http success" do
        post users_path, params: { user: FactoryBot.attributes_for(:invalidUser) }
        expect(response).to have_http_status(:success)
      end

      it "should not create new user" do
        expect{
          post users_path, params: { user: FactoryBot.attributes_for(:invalidUser) }
        }.to change{ User.count }.by(0)
      end
    end
    
    context "when the data is valid " do
      it "should return http success" do
        post users_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to have_http_status(302)
      end

      it "should create new user" do
        expect{
          post users_path, params: { user: FactoryBot.attributes_for(:user) }
        }.to change{ User.count }.by(1)
      end
    end  
  end

  describe "GET /user/params[:user_id]/edit" do
    let!(:user){ FactoryBot.create(:user)}

    it "returns http success" do
      get edit_user_path(user)
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /users" do
    it "should return http success" do
      get users_path
      expect(response).to have_http_status(302)
    end  
  end  
end
