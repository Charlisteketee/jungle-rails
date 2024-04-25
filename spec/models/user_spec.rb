require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is not valid without an email" do
      user = User.new(first_name: "Jackie", last_name: "Chan", password: "tootles", password_confirmation: "toodles")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is not valid without a first name" do
      user = User.new(email: "jackie@example.com", last_name: "Chan", password: "toodles", password_confirmation: "toodles")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "is not valid without a last name" do
      user = User.new(email: "jackie@example.com", first_name: "Jackie", password: "toodles", password_confirmation: "toodles")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "is not valid without a password" do
      user = User.new(email: "jackie@example.com", first_name: "Jackie", last_name: "Chan", password_confirmation: "toodles")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is not valid without a matching password confirmation" do
      user = User.new(email: "john@example.com", first_name: "Jackie", last_name: "Chan", password: "password", password_confirmation: "idontremember")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is not valid with a password shorter than 6 characters" do
      user = User.new(email: "jackie@example.com", first_name: "Jackie", last_name: "Chan", password: "umm", password_confirmation: "umm")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "is not valid with a duplicate email" do
      User.create(email: "jackie@example.com", first_name: "Jackie", last_name: "Chan", password: "toodles", password_confirmation: "toodles")
      user = User.new(email: "jackie@example.com", first_name: "Jackie", last_name: "Chan", password: "password", password_confirmation: "password")
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
   it "authenticates a user with correct credentials" do
      # setup
      user = User.create(email: "jackie@example.com", first_name: "Jackie", last_name: "Chan", password: "toodles", password_confirmation: "toodles")
      
      # exercize
      result = User.authenticate_with_credentials("jackie@example.com", "toodles")
      
      # verify
      expect(result).to have_attributes(
        email: "jackie@example.com",
        first_name: "Jackie",
        last_name: "Chan"
      )
    end
   
    it "does not authenticate a user with the wrong credentials" do
      user = User.create(email: "jackie@example.com", first_name: "Jackie", last_name: "Chan", password: "toodles", password_confirmation: "toodles")
      result = User.authenticate_with_credentials("  jackie@example.com  ", "toodles")

      expect(result).to have_attributes(
        email: "jackie@example.com",
        first_name: "Jackie",
      )  
    end
   
    it "authenticates a user with email in upper case" do
      user = User.create(email: "jackie@example.com", first_name: "Jackie", last_name: "Chan", password: "toodles", password_confirmation: "toodles")
      result = User.authenticate_with_credentials("JACKIE@EXAMPLE.COM", "toodles")

      expect(result).to have_attributes(
        email: "jackie@example.com",
        first_name: "Jackie",
      )
    end
  end
end
