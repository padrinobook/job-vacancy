require 'spec_helper'

RSpec.describe "/job_offers" do
  let(:user) { build_stubbed(:user) }
  describe "GET /jobs" do
    it "render the :jobs view" do
      get "/jobs"
      expect(last_response).to be_ok
    end
  end

  describe "GET /jobs/mylist" do
    context "user is not logged in" do
      it 'redirects to login' do
        expect(User).to receive(:find_by_id).and_return(nil)
        get '/jobs/mylist'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to include('/login')
      end
    end

    context "user is logged in" do
      it 'renders list of users job offers' do
        expect(User).to receive(:find_by_id).and_return(user, user)
        get "/jobs/mylist"
        expect(last_response).to be_ok
      end
    end
  end


  describe "POST /job_offers/create" do
    context "user is not logged in" do
      it 'redirects to login' do
        expect(User).to receive(:find_by_id).and_return(nil)
        post '/job_offers/create'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to include('/login')
      end
    end

    context "user is logged in" do
      it 'renders the post page if form is invalid' do
        @job_offer = double(JobOffer)
        expect(User).to receive(:find_by_id).and_return(user, user)
        expect(JobOffer).to receive(:new).and_return(@job_offer)
        expect(@job_offer).to receive(:valid?).and_return(false)

        post '/job_offers/create'
        expect(last_response).to be_ok
      end

      it 'list page if job offer is saved' do
        @job_offer = double(JobOffer)
        expect(User).to receive(:find_by_id).and_return(user, user)
        expect(JobOffer).to receive(:new).and_return(@job_offer)
        expect(@job_offer).to receive(:valid?).and_return(true)
        expect(@job_offer).to receive(:write_attribute)
          .with(user: user)
          .and_return(true)

        expect(@job_offer).to receive(:save).and_return(true)

        post '/job_offers/create', job_offer: @job_offer
        expect(last_response).to be_redirect
        expect(last_response.body).to eq "Job is saved"
      end
    end
  end

  describe "PUT /job_offers/myjobs/:id" do
    it 'try to edit non existing job' do
      updated_job_offer = ['']
      expect(JobOffer).to receive(:find)
        .with('1000')
        .and_return(nil)

      put "/job_offers/myjobs/1000", job_offer: updated_job_offer

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/jobs/mylist')
    end

    it 'job_offer changes are not valid' do
      @existing_job_offer = double(JobOffer, id: 1, title: 'old')
      updated_job_offer = ['']
      expect(JobOffer).to receive(:find)
        .with('1')
        .and_return(@existing_job_offer)
      expect(@existing_job_offer).to receive(:update_attributes)
        .with(updated_job_offer)
        .and_return(false)

      put "/job_offers/myjobs/1", job_offer: updated_job_offer

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/job_offers/myjobs/1')
      expect(last_response.body).to eq 'Job offer was not updated.'
    end

    it 'job_offer changes are valid' do
      @existing_job_offer = double(JobOffer, id: 1, title: 'old')
      updated_job_offer = ['']
      expect(JobOffer).to receive(:find)
        .with('1')
        .and_return(@existing_job_offer)
      expect(@existing_job_offer).to receive(:update_attributes)
        .with(updated_job_offer)
        .and_return(true)

      put "/job_offers/myjobs/1", job_offer: updated_job_offer

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/jobs/mylist')
      expect(last_response.body).to eq 'Job offer was updated.'
    end
  end
end
