require 'spec_helper'

describe "User Model" do
  let(:user) { build(:user) }

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

  it 'have no blank name' do
    user.name = ""
    user.should_not be_valid
  end

  it 'have no blank email' do
    user.email = ""
    user.should_not be_valid
  end

  it 'have no blank password' do
    user.password = ""
    user.should_not be_valid
  end

  describe "when name is already used" do
    let(:user_second) { build(:user) }

    it 'should not be saved' do
      user_second.name = user.name
      user_second.should_not be_valid
    end
  end

  describe "when email adress is already used" do
    let(:user_second) { build(:user) }

    it 'should not save an user with an existing adress' do
      user_second.email = user.email
      user_second.should_not be_valid
    end
  end

  describe "valid email address" do
    let(:user_second) { build(:user) }

    it 'is valid' do
      adresses = %w[test@test.de hero@movie.com]
      adresses.each do |email|
        user_second.email = email
        user_second.should be_valid
      end
    end
  end

  describe "not valid email adress" do
    let(:user_second) { build(:user)}

    it 'not save them' do
      adresses = %w[spamspamspam.de heman,test.com]
      adresses.each do |email|
        user_second.email= email
        user_second.should_not be_valid
      end
    end
  end

  pending('the password should have a min lenght of 5 characters')
end
