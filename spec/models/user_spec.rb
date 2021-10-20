require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(first_name: "John", last_name: "Smith", email: "john@smith.com", password: "testpass", password_confirmation: "testpass")
  end

  describe "Validations" do
    it "should be valid with all fields present" do
      expect(@user).to be_valid
    end
    it "should be invalid when the password and its confirmation are not the same" do
      @user.password_confirmation = "testpas"
      expect(@user).to_not be_valid
    end
    it "should be invalid if the email is not unique" do
      @user.save
      @user2 = User.new(first_name: "Jane", last_name: "Doe", email: "johN@smith.com", password: "passtest", password_confirmation: "passtest")
      expect(@user2).to_not be_valid
    end
    it "should be invalid if the password is shorter than 6 characters" do
      @user.password = "test"
      @user.password_confirmation = "test"
      expect(@user).to_not be_valid
    end
  end

  describe ".authenticate_with_credentials" do
    before(:each) do
      @user.save
    end

    it "should login with the proper credentials" do
      login = @user.authenticate_with_credentials("john@smith.com", "testpass")
      expect(login).to_not be_nil
    end
    it "should not login with improper credentials" do
      login = @user.authenticate_with_credentials("john@smith.com", "wrongpass")
      expect(login).to be_nil
    end
    it "should not be affected by leading/trailing spaces" do
      login = @user.authenticate_with_credentials(" john@smith.com ", "testpass")
      expect(login).to_not be_nil
    end
  end
end
