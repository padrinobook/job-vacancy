require 'spec_helper'

RSpec.describe "/job_offers" do
  let(:user) { build_stubbed(:user) }
  describe "GET list" do
    it "render the :list view" do
      get "/job_offers/list"
      expect(last_response).to be_ok
    end
  end

  describe "GET my_list" do
    context "user is not logged in" do
      it 'redirects to login' do
        expect(User).to receive(:find_by_id).and_return(nil)
        get '/job_offers/mylist'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to include('/login')
      end
    end

    context "user is logged in" do
      it 'renders list of users job offers' do
        expect(User).to receive(:find_by_id).and_return(user, user)
        get "/job_offers/mylist"
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
end
