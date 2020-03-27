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
        expect(response).to have_http_status(302)
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
        expect(response).to have_http_status(:success)
      end

      it "should create new user" do
        expect{
          post users_path, params: { user: FactoryBot.attributes_for(:user) }
        }.to change{ User.count }.by(1)
      end
    end  
  end

  describe "GET /users/params[:user_id]/edit" do
    let!(:user){ FactoryBot.create(:user)}

    it "returns http success" do
      post login_path, params: { session: {email: user.email, password: user.password}}
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /users" do
    let!(:user){ FactoryBot.create(:user)}
    
    it "should return http success" do
      post login_path, params: { session: {email: user.email, password: user.password}}
      get users_path
      expect(response).to have_http_status(:success)
    end  
  end

  describe "Patch /users/params[:user_id]" do
    let!(:other_user) { FactoryBot.create(:user) }
    it "shouldn't update the admin attribute by user" do
      post login_path, params: { 
        session: {
          email: other_user.email,
          password: other_user.password,
          remember_me: '0'
        }
      }
      patch user_path(other_user), params: {
        user: {
          password: 'beChanged',
          password_confirmation: 'beChanged',
          admin: 'true'
        }
      }
      expect(other_user.admin?).to be_falsey
    end  
  end
  
  describe "Delete /users/params[:id]" do
    let!(:user){ FactoryBot.create(:user)}
    let!(:other_user){ FactoryBot.create(:user)}
    let!(:admin){ FactoryBot.create(:adminUser) }
  
    context "without user's logging in" do
      it "shouldn't change anything" do
        expect{
          delete user_path(other_user)
        }.to change{ User.count }.by(0)
      end  
    end

    context "with user's logging in" do
      it "shouldn't change anything" do
        post login_path, params: { 
          session: {
            email: user.email,
            password: user.password,
            remember_me: '0'
          }
        }
        expect{
          delete user_path(other_user)
        }.to change{ User.count }.by(0)
      end
    end

    context "with admin user's logging in" do
      it "should delete user infromation in database" do
        post login_path, params: { 
          session: {
            email: admin.email,
            password: admin.password,
            remember_me: '0'
          }
        }
        expect{
          delete user_path(other_user)
        }.to change{ User.count }.by(-1)
      end   
    end  
  end  
end
