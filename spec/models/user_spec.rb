require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: "Teresa", email: "teresa@example.com", password: "computer", password_confirmation: "computer")}

  it "is valid" do
    expect(user).to be_valid
  end

  it "is invalid without name attribute" do
    user = User.new(name: "   ", email: "teresa@example.com")
    expect(user).not_to be_valid
  end

  it "is invalid without email attribute" do
    user = User.new(name: "Teresa", email: "")
    expect(user).not_to be_valid
  end

  it "has a name under 50 characters" do
    user = User.new(name: "JohnJacobJingleHeimerSmithThatsMyNameTooWheneverWeGoOutThePeopleAlwaysShoutThereGoesJohnJacobJingleheimerSmith", email: "johnjacob@jingleheimer.net")
    expect(user).not_to be_valid
  end

  it "has an email under 255 characters" do
    user = User.new(name: "JohnJacob", email: "johnjacobjingleheimersmiththatsmynametoowheneverwegooutthepeoplealwaysshouttheregoesjohnjacobjingleheimersmithdaddadadadadadadaohnjacobjingleheimersmithhatsmynametoowheneverwegooutthepeoplealwaysshouttheregoesjohnjacobjingleheimersmithdadada@jingleheimer.net")
    expect(user).not_to be_valid
  end

  it "accepts valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it "rejects invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).not_to be_valid
    end
  end

  it "requires a unique email address and accounts for case insensitivity" do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).not_to be_valid
  end

  it "does not allow duplication in database by way of adding an index to the user table" do
    #not sure how to test for this, ask Rachel/Josh
  end

  it "ensures email uniqueness by downcasing the email attribute" do
    #in the user_spec needs to say before_save { self.email = email.downcase }
    #Also not sure  how to test for this, ask!:)
  end

  it "password should have a minimum length" do
    user.password = user.password_confirmation = "comp"
    expect(user).not_to be_valid
  end

end


