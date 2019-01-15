require 'spec_helper'

describe "JobOffer Model" do
  let(:job_offer) { build_stubbed(:job_offer) }
  let(:wrong_job_offer) { JobOffer.new }

  it 'can be created' do
    expect(job_offer).not_to be_nil
  end

  it 'must have a title' do
    wrong_job_offer.title = ''
    wrong_job_offer.description = 'hallo'

    expect(wrong_job_offer.valid?).to be_falsey
  end

  it 'must have a description' do
    wrong_job_offer.title = 'Hallo'
    wrong_job_offer.description = ''

    expect(wrong_job_offer.valid?).to be_falsey
  end

  it 'must have a location' do
    wrong_job_offer.title = 'Hallo'
    wrong_job_offer.description = 'hallo'
    expect(wrong_job_offer.valid?).to be_falsey
  end

  it 'must have a contact' do
    wrong_job_offer.title = 'Hallo'
    wrong_job_offer.description = 'hallo'
    wrong_job_offer.location = 'Berlin'
    wrong_job_offer.contact = ''
    expect(wrong_job_offer.valid?).to be_falsey
  end

  it 'must have a time_start' do
    wrong_job_offer.title = 'Hallo'
    wrong_job_offer.description = 'hallo'
    wrong_job_offer.location = 'Berlin'
    wrong_job_offer.contact = 'Test'
    expect(wrong_job_offer.valid?).to be_falsey
  end
end
