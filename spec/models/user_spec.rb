require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do

    it "should throw an error if there is no password" do
      user1 = User.create(first_name: "Amrinder", last_name:"Singh", email: "amrinder995@gmail.com", password: nil, password_confirmation: "1234")
      expect(user1).to_not be_valid
    end

    it "should throw an error if there is no password_confirmation" do
      user1 = User.create(first_name: "Amrinder", last_name:"Singh", email: "amrinder995@gmail.com", password: "123456", password_confirmation: nil)
      expect(user1).to_not be_valid
    end

    it "should throw an error if the password and password_confirmation do not match" do
      user1 = User.create(first_name: "Amrinder", last_name:"Singh", email: "amrinder995@gmai.com", password: "123456", password_confirmation: "12356")
      expect(user1).to_not be_valid
    end

    it "should throw an error if there is no password and password_confirmation" do
      user1 = User.create(first_name: "Amrinder", last_name:"Singh", email: "amrinder995@gmail.com", password: nil, password_confirmation: nil)
      expect(user1).to_not be_valid
    end

    it "should throw an error if there is an existing email" do
      user1 = User.create(first_name: "Amrinder", last_name:"Singh", email: "amrinder995@gmail.com", password: "123456", password_confirmation: "123456")
      user2 = User.new(first_name: "Another", last_name:"User", email: "amrinder995@gmail.com", password: "567890", password_confirmation: "567890")
      user2.save
      expect(user2.errors[:email]).to include("has already been taken")
    end

    it "should throw an error if there is no email" do
      user1 = User.create(first_name: "Amrinder", last_name: "Singh", email: nil, password: "123456", password_confirmation: "123456")
      expect(user1).to_not be_valid
    end

    it "should throw an error if there is no first name" do
      user1 = User.create(first_name: nil, last_name: "Singh", email: "amrinder995@gmail.com", password: "123456", password_confirmation: "123456")
      expect(user1).to_not be_valid
    end

    it "should throw an error if there is no last name" do
      user1 = User.create(first_name: "Amrinder", last_name: nil, email: "amrinder995@gmail.com", password: "123456", password_confirmation: "123456")
      expect(user1).to_not be_valid
    end

  end

  describe "Password minimum length" do
    it "should throw an error if the password is not atleast 6 characters" do
      user1 = User.create(first_name: "Amrinder", last_name: "Singh", email: "amrinder995@gmail.com", password: "1234", password_confirmation: "1234")
      expect(user1.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end

  describe ".authenticate_with_credentials" do
    
    before do
      @user = User.create(first_name: "Amrinder", last_name: "Singh", email: "amrinder995@gmail.com", password: "123456", password_confirmation: "123456")
    end
    
    it "returns the user if authentication is successful" do
      authenticated_user = User.authenticate_with_credentials("amrinder995@gmail.com", "123456")
      expect(authenticated_user).to eq(@user)
    end

    it "returns nil if authentication fails" do
      authenticated_user = User.authenticate_with_credentials("amrinder995@gmail.com", "wrongpass")
      expect(authenticated_user).to be_nil
    end

    it "allows you to login with wrong case for email" do
      authenticated_user = User.authenticate_with_credentials("AMrinDER995@gmAIL.com", "123456")
      expect(authenticated_user).to eq(@user)
    end

    it "allows you to login with extra whitespace before and/or after their email" do 
      authenticated_user = User.authenticate_with_credentials("     amrinder995@gmail.com   ", "123456")
      expect(authenticated_user).to eq(@user)
    end
    
  end

end
