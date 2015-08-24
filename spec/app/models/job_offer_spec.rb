require 'spec_helper'

describe "JobOffer Model" do
  let(:job_offer) { JobOffer.new }
  it 'can be created' do
    expect(job_offer).not_to be_nil
  end
end
