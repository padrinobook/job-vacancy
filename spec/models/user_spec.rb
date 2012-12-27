require 'spec_helper'

describe "User Model" do
  let(:user) { FactoryGirl.build(:user) }
  let(:job_offer) { {:title => 'Padrino Engineer 2', :location => 'Berlin', :description => 'Come to this great place'} }
  it 'can be created' do
    user.should_not be_nil
  end

  it 'fresh user should have no offers' do
    user.job_offers.size.should == 0
  end

  it 'have job-offers' do
    user.job_offers.build(job_offer)
    user.job_offers.size.should == 1
  end

end
