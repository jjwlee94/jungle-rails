require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = User.new({ 
      :first_name => "Pika", 
      :last_name => "Chu", 
      :email => "pikachu@pokemon.com", 
      :password => "pokemon", 
      :password_confirmation => "pokemon" 
      })
  end

  describe "Validation" do
    it "should save" do
      @user.save
      expect(@user).to be_present
    end

    it "should match both passwords" do
      @user.password_confirmation = "nintendo"
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should have a first name" do
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "should have a last name" do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should have an email" do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should have a password" do
      @user.password = nil
      @user.save
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should have a password length of more than 5 characters" do
      @user.password = "poke"
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe "authenticate_with_credentials" do
    it "should log in user" do
      @user.save
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eql(@user)
    end

    it "should not log in user with incorrect email" do
      @user.save
      expect(User.authenticate_with_credentials("eevee@pokemon.com", @user.password)).to eql(nil)
    end

    it "should not log in user with incorrect password" do
      @user.save
      expect(User.authenticate_with_credentials(@user.email, "eevee")).to eql(nil)
    end

    it "should log in user with white spaces around email" do
      @user.save
      expect(User.authenticate_with_credentials("  pikachu@pokemon.com  ", @user.password)).to eql(@user)
    end

    it "should log in user without case sensitivity" do
      @user.save
      expect(User.authenticate_with_credentials("PIKAchu@pokemon.com", @user.password)).to eql(@user)
    end
  end
end