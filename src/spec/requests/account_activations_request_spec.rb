require 'rails_helper'

RSpec.describe "AccountActivations", type: :request do
  describe "Get /account_activation/params[:id]/edit" do
    let!(:user){ FactoryBot.create(:deactivatedUser) }
    
    it "should changer user's activated status from false to true" do
      get edit_account_activation_path(user.activation_token, email: user.email)
      expect(user.reload.activated?).to be_truthy
    end  
  end  
end
