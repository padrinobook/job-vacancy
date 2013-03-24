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
    it 'no blank password' do
      user.password = ""
      user.should_not be_valid
    end

    it 'no blank password confirmation' do
      user.password_confirmation = ""
      user.should_not be_valid
    end

    it 'password and password_confirmation should fail if not equal' do
      user.password = "abcdefg"
      user.password_confirmation = "abcdefgh"
      user.should_not be_valid
    end

    it 'password and password_confirmation should be equal' do
      user.password = "foobaraa"
      user.password_confirmation = "foobaraa"
      user.should be_valid
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
      user_second.save.should be_false
    end
  end

  describe "valid email address" do
    it 'is valid' do
      adresses = %w[test@test.de hero@movie.com]
      adresses.each do |email|
        user_second.email = email
        user_second.should be_valid
      end
    end
  end

  describe "not valid email address" do
    it 'not valid' do
      adresses = %w[spamspamspam.de heman,test.com]
      adresses.each do |email|
        user_second.email= email
        user_second.should_not be_valid
      end
    end
  end

  it 'password length should be at least 5 characters long' do
    user.password = "foo"
    user.should_not be_valid
  end

end
