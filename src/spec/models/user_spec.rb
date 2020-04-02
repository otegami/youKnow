require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe "Validation" do
    it "should check the existence" do
      expect(@user.valid?).to eq (true)
    end
    it "should check the existence of name" do
      @user.name = ""
      expect(@user.invalid?).to eq (true)
    end
    it "should check the existence of email" do
      @user.email = ""
      expect(@user.invalid?).to eq (true)
    end
    it "should check whether the length of name is over 51 or not." do
      @user.name = "a" * 51
      expect(@user.invalid?).to eq (true)
    end
    it "should check whether the length of email is over 256 or not." do
      @user.name = "a" * 244 + "@example.com"
      expect(@user.invalid?).to eq (true)
    end
    it "should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A__US_ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user.valid?).to eq (true)
      end
    end
    it "should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user.invalid?).to eq (true)
      end
    end
    it "should check whether the address is unique or not" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save!
      expect(duplicate_user.invalid?).to eq (true)
    end
    it "should make email be lowercase before saving to database" do
      mixed_case_email = "Foo@ExAMPLe.CoM"
      @user.email = mixed_case_email
      @user.save!
      expect(@user.reload.email).to eq (mixed_case_email.downcase)
    end
    it "should check the existence of password" do
      @user.password = @user.password_confirmation = "" * 6
      expect(@user).to be_invalid
    end
    context "Checking the length of password" do
      it "should check whether the length is under 5" do
        @user.password = @user.password_confirmation = "a" * 5
        expect(@user).to be_invalid
      end
      it "should check whether the length is over 6" do
        @user.password = @user.password_confirmation = "a" * 6
        expect(@user).to be_valid
      end
    end  
  end

  describe "Authenticated?" do
    it "should return false for a user with nil digest" do
      expect(@user.authenticated?(:remember, '')).to be_falsey
    end  
  end

  # I will rewrite this test later beacase of having changed tabole
  # describe "with Project model" do
  #   it "associated project should be deleted" do
  #     user = FactoryBot.create(:user)
  #     user.projects.create( name: "test project", description: "test" )
  #     expect{ user.destroy }.to change{ Project.count }.by(-1)
  #   end
  # end
end