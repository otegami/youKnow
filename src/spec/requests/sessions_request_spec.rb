require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  
  describe "GET /login" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
  describe "POST /login" do
    context "when the user's data is invalid" do 
      it "return http success" do 
        post login_path, params: { 
          session: {
            email: "",
            password: "",
            remember_me: '1'
          }
        }
        expect(response).not_to have_http_status(302)
      end  
    end
    context "when the user's data is valid" do 
      it "return http success" do 
        post login_path, params: { 
          session: {
            email: user.email,
            password: user.password,
            remember_me: '0'
          }
        }
        expect(response).to have_http_status(302)
      end
    end  
  end  
end
