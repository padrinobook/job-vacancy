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
    user.save.should be_false
  end

  it 'have no blank email' do
    user.email = ""
    user.save.should be_false
  end

  it 'have no blank password' do
    user.password = ""
    user.save.should be_false
  end

  describe "when name is already used" do
    let(:user_second) { build(:user) }

    it 'should not be saved' do
       user_second.save.should be_false
    end
  end

  describe "when email adress is already used" do
    let(:user_second) { build(:user) }

    it 'should not save an user with an existing adress' do
      user_second.name = "Hansi"
      user_second.email = user.email
      user_second.save.should be_false
    end
  end

  pending('have a valid email')
  pending('the password should have a min lenght of 5 characters')
  pending('the password and password confirmation should be equal')
end
