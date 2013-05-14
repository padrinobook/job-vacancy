require 'spec_helper'

describe "JobOffer Model" do
  let(:job_offer) { JobOffer.new }
  it 'can be created' do
    job_offer.should_not be_nil
  end
end
