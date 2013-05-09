require 'spec_helper'

describe "User Model" do
  let(:user) { build(:user) }
  let(:user_second) { build(:user)}

  it 'can be created' do
    user.should_not be_nil
  end

  it 'fresh user should have no offers' do
    user.job_offers.size.should == 0
  end

  it 'have job-offers' do
    user.job_offers.build(attributes_for(:job_offer))
    user.job_offers.size.should == 1
  end

  it 'no blank name' do
    user.name = ""
    user.should_not be_valid
  end

  it 'no blank email' do
    user.email = ""
    user.should_not be_valid
  end

  describe "passwords" do
    let(:user_confirmation) { build(:user)}
    it 'no blank password' do
      user_confirmation.password = ""
      user_confirmation.should_not be_valid
    end

    it 'password length should be at least 5 characters long' do
      user_confirmation.password = "octo"
      user_confirmation.should_not be_valid
    end

  end

  describe "when name is already used" do
    it 'should not be saved' do
      user.save
      user_second.name = user.name
      user_second.should_not be_valid
    end
  end

  describe "when email address is already used" do
    it 'should not save an user with an existing address' do
      user.save
      user_second.email = user.email
      user_second.should_not be_valid
    end
  end

  describe "email address" do
    it 'valid' do
      adresses = %w[thor@marvel.de hero@movie.com]
      adresses.each do |email|
        user_second.email = email
        user_second.name= email
        user_second.should be_valid
      end
    end

    it 'not valid' do
      adresses = %w[spamspamspam.de heman,test.com]
      adresses.each do |email|
        user_second.email= email
        user_second.should_not be_valid
      end
    end
  end

  describe "confirmation code" do
    let(:user_confirmation) { build(:user) }

    it 'should authenticate user with correct confirmation code' do
      user_confirmation.save
      confirmation_of_saved_user = User.find_by_id(user_confirmation.id)
      user_confirmation.confirmation_code = confirmation_of_saved_user.confirmation_code
      user_confirmation.authenticate(user_confirmation.confirmation_code).should be_true
    end

    it 'confirmation should be set true after a user is authenticated' do
      user_confirmation.save
      confirmation_of_saved_user = User.find_by_id(user_confirmation.id)
      user_confirmation.confirmation_code = confirmation_of_saved_user.confirmation_code
      user_confirmation.authenticate(user_confirmation.confirmation_code).should be_true
      user_confirmation.confirmation.should be_true
    end

    it 'should not authenticate user with incorrect confirmation code' do
      user_confirmation.authenticate("wrong").should be_false
    end
  end
end
