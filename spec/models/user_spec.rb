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

end
